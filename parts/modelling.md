## Modelling

We described the extracted data with a semantic data model.
Our goal of modelling data was to establish a structure that can be leveraged by matchmaking.
However, modelling data in RDF is typically agnostic of its expected use.
Instead, it is guided by a conceptual model that opens the data to a wide array of ways to reuse the data.
Nevertheless, the way we chose model our data reflected our priorities.

We focused on querying and data integration instead of reasoning.
Instead of enabling to draw logical inferences by reasoning with ontological constructs, we wanted to simplify and speed-up querying.
In order to do that, for example, we avoided verbose structures to reduce the size of the queried data.
For the sake of better integration with other data, we established IRIs as persistent identifiers and reused common identifiers where possible.
Thanks to the schema-less nature of RDF, any datasets can be merged automatically.

The extracted public procurement data was described using a mixture of RDF vocabularies, out of which the Public Contracts Ontology was the most prominent.
