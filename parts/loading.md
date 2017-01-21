## Loading

The aim of loading is to expose data in a way matchmaking methods can operate on efficiently.
Our three approaches to matchmaking warrant three approaches to loading.

<!-- SPARQL-based matchmaking -->

The SPARQL-based matchmaking requires data to be available via the SPARQL protocol ([Feigenbaum et al., 2013](#Feigenbaum2013)).
SPARQL protocol describes the communication between clients and SPARQL endpoints, which provide query interface to RDF stores.
Exposing data via the SPARQL protocol thus requires simply to load it in an RDF store equipped with a SPARQL endpoint.
We chose to use the open-source version of [Virtuoso](https://virtuoso.openlinksw.com) from OpenLink as our RDF store.
Even though Virtuoso lacks in stability and adherence to the SPARQL standard, it redeems that by offering a performance unparalleled by other open-source solutions.
We used Virtuoso's [bulk loader](https://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtBulkRDFLoader) to ingest RDF data into the store.

<!-- Elasticsearch-based matchmaking -->

The matchmaking based on full-text search requires a search engine.
We chose [Elasticsearch](https://www.elastic.co/products/elasticsearch) because of its expressive query DSL that allows us to formulate complex matchmaking queries.
Full-text search engines typically require regular data structures to make indexing efficient.
Heterogeneity of public procurement data thus mandates pre-processing to make the data more regular.
Greater regularity of RDF data can be achieved by serializing it into JSON-LD ([Sporny et al., 2014](#Sporny2014)) and coercing it to a tree layout via JSON-LD Framing ([Longley et al., 2016](#Longley2016)).

We developed a CLI tool to perform this task.
[sparql-to-jsonld](https://github.com/jindrichmynarz/sparql-to-jsonld) retrieves data from a SPARQL endpoint and converts it to JSON-LD.
It requires a SPARQL SELECT query to select IRIs of the RDF resources of interest, a SPARQL CONSTRUCT query to define their descriptions, and a JSON-LD frame to coerce the obtained RDF graphs describing the resources into a regular JSON-LD tree layout.
The SPARQL CONSTRUCT query is used to select or construct relevant features of the described resource.
The provided JSON-LD frame is used twice: first as a frame with the JSON-LD Framing API and then as a context for the JSON-LD compaction ([Longley et al., 2014](#Longley2014)) to shorten IRIs and JSON-LD values.
The tool outputs [Newline Delimited JSON](http://ndjson.org) (NDJSON) that features each framed description on a separate line.

The resulting NDJSON is indexed in Elasticsearch using [jsonld-to-elasticsearch](https://github.com/jindrichmynarz/jsonld-to-elasticsearch), another CLI tool we created.
The tool partitions its input data into batches and transforms NDJSON to [Elasticsearch bulk load format](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html).
Each batch is then indexed in Elasticsearch using a provided mapping, which defines how to analyze and store the provided data.
<!--
TODO: Describe the concrete SPARQL CONSTRUCT query used, together with its Elasticsearch mapping, once we have a working Elasticsearch matchmaker.
--> 

<!-- Web of Needs-based matchmaking -->

<!--
TODO: What storage mechanism is used for RESCAL?
-->

<!--
[sparql-to-csv](https://github.com/jindrichmynarz/sparql-to-csv) is a tool for loading RDF data from a SPARQL endpoint to CSV in order to support data analyses requiring tabular data.
-->