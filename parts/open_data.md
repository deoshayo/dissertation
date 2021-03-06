### Open data {#sec:open-data}

Open data is data that can be accessed equally by people and machines.
Its definition is grounded in principles that assert what conditions data must meet to achieve legal and technical openness.
Principles of open data are perhaps best embodied in the Open Definition [@OpenDefinition2015] and the Eight principles of open government data [-@EightPrinciples2007]. 
According to the Open Definition's summary, *"open data and content can be freely used, modified, and shared by anyone for any purpose."*^[<http://opendefinition.org>]
<!-- Legal conditions of open data are usually established via a licence or waiver, such as the Open Data Commons Public Domain Dedication and Licence (ODC PDDL).^[<https://opendatacommons.org/licenses/pddl/1.0>] -->
The Eight principles of open government data draw similar requirements as the Open Definition and add demands for completeness, primacy, and timeliness.

Open data is particularly prominent in the public sector, since public sector data is subject to disclosure mandated by law.
Open data can be a result of either reactive disclosure, such as upon Freedom of Information requests, or proactive disclosure, such as by publishing open data. 
In case of the EU, disclosure of public sector data is regulated by the directive 2013/37/EU on the re-use of public sector information [@EU2013].

While releasing open data is frequently framed as a means to improve transparency of the public sector, it can also have a positive effect on its efficiency [@AccessInfoEurope2011, p. 69], since the public sector itself is often the primary user of open data.
Using open data can help streamline public sector processes [@Parycek2014, p. 90] and curb unnecessary expenditures [@Presern2014, p. 4].
The publication of public procurement data is claimed to improve *"the quality of government investment decision-making"* [@Kenny2012, p. 2], as supervision enabled by access to data puts a pressure on contracting authorities to follow fair and budget-wise contracting procedures.
Matchmaking public contracts to relevant suppliers can be considered an application of open data that can contribute to better-informed decisions leading to more economically advantageous contracts.

Open data can help balance information asymmetries between participants of public procurement markets.
The asymmetries may be caused by clientelism, siloing data in applications with restricted access, or fragmentation of data across multiple sources.
Open access to public procurement data can increase the number of participants in procurement, since more bidders can learn about relevant opportunities if they are advertised openly. 
Even distribution of open data may eventually lead to better decisions of the market participants, thereby increasing the efficiency of resource allocation in public procurement.

Open data addresses two fundamental problems of recommender systems, which apply to matchmaking as well.
These problems comprise the cold start problem and data sparseness, which can be jointly described as the data acquisition problem [@Heitmann2010].
Cold start problem concerns the lack of data needed to make recommendations.
It appears in new recommender systems that have yet to acquire users to amass enough data to make accurate recommendations.
Open data ameliorates this problem by allowing to bootstrap a system from openly available datasets.
In our case, we use open data from business registers to obtain descriptions of business entities that have not been awarded a contract yet, in order to make them discoverable for matchmaking.
Data sparseness refers to the share of missing values in a dataset. 
If a large share of the matched entities is lacking values of the key properties leveraged by matchmaking, the quality of matchmaking results deteriorates.
Complementary open datasets can help fill in the blank values or add extra features [@DiNoia2015, p. 102] that improve the quality of matchmaking.

The hereby presented work was done within the broader context of the OpenData.cz^[<http://opendata.cz>] initiative.
OpenData.cz is an initiative for a transparent data infrastructure of the Czech public sector.
It advocates adopting open data and linked data principles for publishing data on the Web.
Our contributions described in [Section @sec:data-preparation] enhance this infrastructure by supplying it with more open datasets and improving the existing ones.
