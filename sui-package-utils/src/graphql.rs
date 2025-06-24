const _GRAPHQL_QUERY: &str = r#"
    query($cursor: String, $afterCheckpoint: UInt53) {
  packages(first: 50, after: $cursor, filter: {
    afterCheckpoint: $afterCheckpoint
  }) {
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      address
      packageBcs
      previousTransactionBlock {
        digest
        sender {
          address
        }
        effects {
          checkpoint {
            sequenceNumber
          }
        }
      }
    }
  }
}
"#;
