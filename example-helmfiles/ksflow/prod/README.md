The [dev helmfile example](../dev/helmfile.yaml) already shows the configuration required for a simple installation.
For production be sure to at a minimum replace the kafka and schema-registry charts with your installations of those (i.e. Confluent, MSK, etc).
Production environments will vary greatly based on needs, so this helmfile example only shows how to configure ksflow.
It's assumed all other dependencies are already installed and kafka and schema registry are set up with mTLS.

Ensure a `ClusterIssuer` exists in the namespace where the ksflow controller runs.
It will use this to create `Certificates` for `KafkaUsers`.  See cert-manager documentation for different Issuers (i.e. [AWS Private Certificate Issuer](https://github.com/cert-manager/aws-privateca-issuer))

The `Certificate` issued for the ksflow controller will also need acl's registered in Kafka to support managing ACLs.
Kafka/Schema Registry likely have similar common name as ksflow
`schema-registry-1.example.com`, `schema-registry-2.example.com`
`kafka-1.example.com`, `kafka-2.example.com`, `kafka-3.example.com`
