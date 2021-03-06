## Fusion {#sec:fusion}

Data fusion can be defined as *"the process of integrating multiple data items representing the same real-world object into a single, consistent, and clean representation"* [@Bizer2009].
In order to reach this goal, data fusion removes invalid or non-preferred data, so that *"duplicate representations are combined and fused into a single representation while inconsistencies in the data are resolved"* [@Bleiholder2008, p. 1:3].
Fusion of RDF data can be considered a counter-measure to the effects of the principle of *Anyone can say anything about anything* (AAA).
As Klyne and Carroll state, *"RDF cannot prevent anyone from making nonsensical or inconsistent assertions, and applications that build upon RDF must find ways to deal with conflicting sources of information"* [-@Klyne2002].

In line with the principle of separation of concerns, data fusion expects equivalence links between conflicting identities to be provided.
However, it is not limited to a mechanical application of the equivalence links produced by linking.
Its particular focus *"lies in resolving value-level contradictions among the different representations of a single real-world object"* [@Naumann2006, p. 22].

Viewed from the perspective of data fusion, linking is a way to discover identity conflicts.
Identity conflicts arise when a single entity is provided with multiple identities.
Identities in RDF correspond either to IRIs or blank nodes.
Resolution of identity conflicts gives rise to data conflicts in turn.
Rewriting an identity with another identity automatically merges the RDF triples in which the identities appear.
Merging RDF triples may consequently cause functional properties to have multiple values, which constitutes a conflict.
<!--
Conflicts handled by data fusion are typically divided into contradictions, where multiple non-null values are provided for a functional property, and uncertainties, where a functional property has both null and a non-null value.
However, since there are no nulls in RDF, conflicts in RDF are limited to contradictions.
-->

Fusion may be executed iteratively, interleaved with linking.
This is expedient in case of large datasets, which are computationally demanding to process.
Iterating fusion with linking allows to shrink the size of the processed data and thus decrease the number of comparisons that linking needs to perform.
Moreover, in case of large datasets, the steps of linking and data fusion may be limited to subsets of data in order to improve the performance of the whole workflow.

<!--
Data from the Czech public procurement register has many characteristics of user-generated content.
Uncoordinated civil servants are akin to the distributed user base of web applications.
Lack of rules and constraints enforced on user input
Exchanging data in self-contained documents
*"the default mode of authoring is copy and edit"* [@Guha2013]

Public procurement data also suffers from shortcomings similar to those of user-generated data.
The users generating data for the public procurement registers usually comprise many contracting authorities.
Each authority may produce data digressing from the mandated data standards in a different way.
Due to the distinct interpretations of the extent of mandatory and discretionary data by contracting authorities, the resulting aggregated dataset may appear to be incomplete.
Additionally, public procurement data is typically collected from forms filled out by people, who may inadvertently or purposely enter errors into the data they create.
A shortcoming of public procurement data that becomes apparent in data integration is the lack of global, agreed-upon and well-maintained identifier schemes for values of attributes of public contracts; such as the award criteria employed in the course of selecting the winning bid for a contract.
Coletta et al. claim that data integration is harder in the context of public sector data because important metadata is often missing [-@Coletta2012].
Fazekas discusses a similar set of issues of public procurement data from Hungary and highlights missing identifiers, imprecise links, and structural weaknesses [@Fazekas2012, p. 14].
A corollary of these issues is that tracking public contracts through the stages of their life-cycle, from their announcement over to completion, is difficult because of the lack of reliable identifiers.
-->

In order to simplify the resolution of identity conflicts, we adopted a conventional directionality of the `owl:sameAs` links from a non-preferred IRI to the preferred IRI.
This convention allowed us to use a uniform SPARQL Update operation to resolve non-preferred IRIs to their preferred counterparts.
For example, if there is a triple `:a owl:sameAs :b`, `:a` as the non-preferred IRI will be rewritten to `:b`.
Note that this convention is applicable only if you can distinguish between non-preferred and preferred IRIs, such as by preferring IRIs from a reference dataset.

Data conflicts arose only in properties that can be interpreted as functional.
Some of these properties explicitly instantiate `owl:FunctionalProperty`, such as `pc:kind` describing the kind of a contract, while others, such as `dcterms:title` expressing the contract's title, can be endowed with this semantics for the purpose of attaining a unified view of the fused data.
Most of our data fusion work was devoted to resolving data from contract notices.
As was the case of identity conflicts, the resolution of data conflicts was done via SPARQL Update operations.

Conflicts are resolved by using resolution functions.
Resolution functions are either *deciding*, which pick one of their inputs, or *mediating*, which derive their output from the inputs.
An example deciding function is picking the maximum value, while an example mediating function is computing the median value.
We employed deciding conflict resolution functions.

### Conflict resolution strategies

The conflict resolution strategies we implemented can be classified according to Bleiholder and Naumann [-@Bleiholder2006].
We used *Trust your friends* [@Bleiholder2006, p. 3] strategy to prefer values from ARES, since we consider it a trustworthy reference dataset.
Leveraging the semantics of notice types, we preferred data from correction notices.
A similar reason led us to remove syntactically invalid RNs in case valid RNs were present too.
We used *Keep up to date* [@Bleiholder2006, p. 3] metadata-based conflict resolution strategy to prefer values from the most recent public notices.
We determined the temporal order of notices from their submission dates and the semantics of their types, which represent an implicit order.
For example, prior information notice comes before contract notice, which in turn precedes contract award notice.
The order of notice types can be *learnt* from the most common order of notices with immediately following submission dates.
We combined such distribution of subsequent notice types with manual assessment to rule out erroneous pairs.
The order of notice types was provided as an inline table to the SPARQL Update operation resolving the conflicts.
In line with this strategy, we also preferred the most recent values of `pc:awardDate`.
We used *Most specific concept* [@Bleiholder2006, p. 4] strategy for resolution of conflicts in values from hierarchical concept schemes.
In case a single functional property linked multiple concepts that were in a hierarchical relation, the most specific concepts were retained.
For instance, we removed procedure types that can be transitively inferred by following `skos:broaderTransitive` links.
We used *No gossiping* [@Bleiholder2006, p. 3] strategy for conflicting boolean values.
If a boolean property has both `true` and `false` value, and there is no way to prioritize a value, we conclude the true value of the property is unknown, and therefore delete both conflicting values.
Once the conflicts were resolved by the above-described strategies, we moved the remaining notice data to the associated contracts, which corresponds to the strategy *Take the information* [@Bleiholder2006, p. 3].
We excluded notice's proper data, such as submission date or notice type, from this step.
If all previous conflict resolution strategies failed, in select cases we followed *Roll the dice* [@Bleiholder2006, p. 5] strategy and picked a random value via the `SAMPLE` aggregate function in SPARQL.
We did this for procedure types (values of `pc:procedureType`), contracting authorities (values of `pc:contractingAuthority`) without valid RNs, and actual prices (values of `pc:actualPrice`).

As the final polishing touch we excised the resources orphaned during data fusion.
Since removing orphans may create more orphans, we deleted orphans in the topological order based on their links.
In this way we first removed orphans, followed by deleting their dependent resources that were orphaned next.

### Evaluation of fusion

If we decide to evaluate the quality of data fusion, there are several measures available.
One of the broadest measures for assessing data fusion is data reduction ratio, which represents the decrease of the number of fused entities.
This figure corresponds to the measure of extensional conciseness defined by Bleiholder and Naumann [-@Bleiholder2008, pp. 1:5-1:6] as the *"percentage of real-world objects covered by that dataset."*
Many evaluation measures used for data fusion reflect the impact of this task on data quality.
An example of those measures is completeness, which represents the ratio of instances having value for a specified property before and after fusion, and is sometimes rephrased as coverage and density [@Akoka2007].

Compared with the raw extracted datasets, fusion decreased the number of distinct entities by 61.68 % to 2 million.
Overall, fusion reduced the data by 52.14 % from 20.5 million triples to 9.8 million.

<!--
[@Bleiholder2008]
Completeness
Conciseness
Consistency
- Intensional and extensional
-->
