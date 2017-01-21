### Access to Registers of Economic Subjects/Entities

[Access to Registers of Economic Subjects/Entities](http://wwwinfo.mfcr.cz/ares/ares.html.en) (ARES) is an information system about business entities, which is maintained by the Ministry of Finance of the Czech Republic.
The data describes business entities along with their registrations required to pursue their business.
It contains legal business entity names, registration dates, their postal addresses, and classifications according to NACE. 
Thanks to these features ARES can serve as a reference dataset for Czech business entities.

This system is not the primary source of the data it provides.
Instead, it mediates data from several source registers and links back to these registers where possible.
The main sources of ARES are the [Public Register](https://or.justice.cz/ias/ui/rejstrik) (PR) run by the Czech Ministry of Justice, the [Trade Licensing Register](http://www.rzp.cz/eng/index.html) (TLR) operated by the Czech Ministry of Industry and Trade, and the [Business Register](https://www.czso.cz/csu/res/business_register) maintained by the Czech Statistical Office.
Consequently, the data ARES provides may not be up-to-date or complete.
ARES explicitly renounces any guarantees about the data.
Its data is not to be treated as legally binding, but instead it serves only an informative purpose.

The benefit of ARES that outweighs its drawbacks is that, unlike the source registers, it provides data in a structured format.
It exposes an [HTTP API](http://wwwinfo.mfcr.cz/ares/ares_xml.html.cz) that allows to retrieve data in XML about one legal entity per request.
The access to data is rate-limited to prevent high load from automated harvesters that may cause unavailability of the service for human users.
The limits allow to issue a thousand requests per day and five thousand requests per night.
Since ARES provides access to hundreds of thousands of business entities and no option for bulk download, harvesting a copy of its data may take many weeks.
The rate-limiting and the prolonged execution thus need to be factored into account when designing an ETL pipeline that obtains the data. 

Since ARES wraps many registers, we narrowed our focus to two registers most relevant to the public procurement: PR and TLR.
These registers are those that the awarded bidders of public contracts are registered in.
A large share of business entities is present in both these registers.
It is nevertheless useful to obtain data from both registers, since they are complementary.
For instance, while the PR contains classification of organization activity according to NACE, TLR naturally provides the trade licences entities have registered.

Valid requests to the ARES API must contain a Registered Identification Number (RN) of a business entity.
This design makes it difficult to obtain a complete copy of the ARES data without a complete list of valid RNs.
We collected a subset of the entire datasets by requesting the RNs we found in other datasets. 
The Czech public procurement register was one such dataset, so we gathered data about all business entities participating in Czech public procurement if their valid RN was published.
The downside of the method is that it potentially leaves out much unidentified business entities, since there are almost 2.8 million business entities in the Business Register as of September 2016^[See the periodical report of the Czech Statistical Office: <https://www.czso.cz/documents/10180/33134052/14007016q301.pdf/db871117-2431-4bba-b8d9-2288cd10862e>] in total.
Moreover, this number excludes now defunct entities that could have participated in the Czech public procurement before their dissolution date.
In total, as of November 2016 we harvested data about 204 620 distinct entities either in PR or TLR.
Out of these, 161 403 business entities were present in both registries.

Thanks to the uniform API that ARES provides the ETL of both registers differs only in the XSL transformations mapping XML data to RDF.
The data transformation was done using [UnifiedViews](https://unifiedviews.eu) ([Knap et al., 2017](#Knap2017)).
UnifiedViews is an ETL tool for producing RDF data, which can be considered a predecessor of LP-ETL.
A [custom data processing unit](https://github.com/mff-uk/DPUs/tree/master/dpu-domain-specific/ares) (DPU) was used to fetch data into UnifiedViews.
Raw source data in XML was transformed into RDF/XML using XSL stylesheets.
A mixture of RDF vocabularies was used to describe the ARES data with the key roles played by the GoodRelations ([Hepp, 2008](#Hepp2008)) and the Registered Organization Vocabulary ([Archer et al., 2013](#RegOrg2013)).
The registry data is relatively consistent, so it did not require much cleaning. 
However, we paid special care to postal addresses, since we needed them for geocoding.
SPARQL Update operations were employed to clean and structure the addresses.
The [data transformation](https://github.com/opendatacz/ARES2RDF) was released as open-source.
Most of the transformation was done by Jakub Klímek from the Charles University in Prague with a contribution of this thesis' author.