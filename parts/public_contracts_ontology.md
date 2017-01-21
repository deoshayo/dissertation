### Public Contracts Ontology

[Public Contracts Ontology](https://github.com/opendatacz/public-contracts-ontology) (PCO) is a lightweight RDF vocabulary for describing data about public contracts.
The vocabulary has been developed by the Czech OpenData.cz initiative since 2011, while this thesis' author has been one of its editors.
Its design is driven by what public procurement data is available, mostly in the Czech Republic and at the EU level. 
The data-driven approach *"implies that vocabularies should not use conceptualizations that do not match well to common database schemas in their target domains"* ([Mynarz, 2014](#Mynarz2014a)).
Yet in fact, since the disclosure of public procurement data is mandated by law, PCO can be indirectly considered a legal ontology.

PCO establishes a reusable conceptual vocabulary to provide a consistent way of describing public contracts.
This aim for reusability corresponds with the established principle of minimal ontological commitment ([Gruber, 1993](#Gruber1993)).
The vocabulary follows a simple snowflake structure oriented around contract as the central concept.
It extensively reuses and links other vocabularies, such as [Dublin Core Terms](http://dublincore.org/documents/dcmi-terms) or [GoodRelations](http://www.heppnetz.de/ontologies/goodrelations/v1.html).
While direct reuse of linked data vocabularies is discouraged by Presutti et al. ([2016](#Presutti2016)), because it introduces a dependency on external vocabulary maintainer and the consequences of the ontological constraints of the reused terms are rarely considered, we argue that these vocabularies are often maintained by organizations more stable than the organization of the vocabulary's creator and that the mentioned ontological constraints are typically non-existent in lightweight linked data vocabularies, such as Dublin Core Terms.
Several properties in PCO have their range restricted to values enumerated in code lists.
For example, there is a code list for procedure types, including open or restricted procedures.
These core code lists are represented using SKOS and are a part of the vocabulary.
The design of PCO is described in more detail in Nečaský et al. ([2014](#Necasky2014)).

The vocabulary was used to a large extent in the [LOD2 project](http://aksw.org/Projects/LOD2.html).
For example, it was applied to Czech, British, EU, or Polish public procurement data.
In this way, we validated the reusability of the vocabulary across various legal environments.

<!--
*Anti-SEO* coined by Jiří Skuhrovec: <http://blog.aktualne.cz/blogy/jiri-skuhrovec.php?itemid=13827>
-->

<!-- 
# Out-takes:

Reasoning with data was its explicit non-goal.
As a result, the vocabulary does not feature sufficient ontological constructs to allow reasoning.
*"The prime aim of vocabulary is communication instead of representation"* ([Mynarz, 2014](#Mynarz2014a)).
While PCO strives for conceptual parsimony, this feature is missing in some source data models that needlessly replicate isomorphic data structures.
For example, the Czech public procurement register numbers XML elements for award criteria (as `Kriterium1`, `Kriterium2` etc.) instead of using one element connected with a relation of higher arity.
-->