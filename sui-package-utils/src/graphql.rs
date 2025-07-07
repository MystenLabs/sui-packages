use base64::prelude::*;
use bcs;
use reqwest;
use serde::{Deserialize, Serialize};
use thiserror::Error;

use sui_types::move_package::MovePackage;

use crate::common_types::MovePackageWithMetadata;

const GRAPHQL_QUERY: &str = r#"
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
            epoch {
              epochId
            }
          }
        }
      }
    }
  }
}
"#;

pub struct PackageGraphQLFetcher {
    initial_checkpoint: u64,
    cursor: Option<String>,
    has_next_page: bool,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]

struct GraphQLRequest {
    query: String,
    variables: PackageGraphQLVariables,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLVariables {
    cursor: Option<String>,
    after_checkpoint: u64,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponse {
    data: Option<PackageGraphQLResponseData>,
    errors: Option<Vec<PackageGraphQLResponseError>>,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseError {
    message: String,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseData {
    packages: PackageGraphQLResponsePackages,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponsePackages {
    page_info: PackageGraphQLResponsePageInfo,
    nodes: Vec<PackageGraphQLResponseNode>,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponsePageInfo {
    has_next_page: bool,
    end_cursor: Option<String>,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseNode {
    address: String,
    package_bcs: String,
    previous_transaction_block: Option<PackageGraphQLResponsePreviousTransactionBlock>,
}

impl TryInto<MovePackageWithMetadata> for PackageGraphQLResponseNode {
    type Error = GraphQLFetcherError;
    fn try_into(self) -> Result<MovePackageWithMetadata, Self::Error> {
        let address = self.address.clone();
        if self.previous_transaction_block.is_none() {
            return Err(GraphQLFetcherError::PreviousTransactionBlockNotAvailable(
                address,
            ));
        }

        // safe: just checked that it's not none
        let previous_transaction_block = self.previous_transaction_block.unwrap();

        let sender = previous_transaction_block.sender.map(|s| s.address.clone());
        let transaction_digest = previous_transaction_block.digest.clone();
        let checkpoint = previous_transaction_block
            .effects
            .checkpoint
            .sequence_number;

        let epoch = previous_transaction_block.effects.checkpoint.epoch.epoch_id;

        let package_bcs = BASE64_STANDARD
            .decode(&self.package_bcs)
            .map_err(GraphQLFetcherError::PackageBcsBase64DecodeError)?;
        let package: MovePackage = bcs::from_bytes(&package_bcs)
            .map_err(|_e| GraphQLFetcherError::PackageBcsDeserializeError(self.address.clone()))?;
        Ok(MovePackageWithMetadata {
            package,
            epoch,
            checkpoint,
            transaction_digest,
            sender: sender.clone(),
        })
    }
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponsePreviousTransactionBlock {
    digest: String,
    effects: PackageGraphQLResponseEffects,
    sender: Option<PackageGraphQLResponseSender>,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseSender {
    address: String,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseEffects {
    checkpoint: PackageGraphQLResponseCheckpoint,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseCheckpoint {
    epoch: PackageGraphQLResponseEpoch,
    sequence_number: u64,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct PackageGraphQLResponseEpoch {
    epoch_id: u64,
}

impl PackageGraphQLFetcher {
    pub fn new(initial_checkpoint: u64, initial_cursor: Option<String>) -> Self {
        Self {
            initial_checkpoint,
            cursor: initial_cursor,
            has_next_page: true,
        }
    }

    fn fetch_once(&self) -> Result<PackageGraphQLResponse, GraphQLFetcherError> {
        let client = reqwest::blocking::Client::new();
        let body = GraphQLRequest {
            query: GRAPHQL_QUERY.to_string(),
            variables: PackageGraphQLVariables {
                cursor: self.cursor.clone(),
                after_checkpoint: self.initial_checkpoint,
            },
        };
        let res = client
            .post("https://sui-mainnet.mystenlabs.com/graphql")
            .header("Content-Type", "application/json")
            .header(
                "User-Agent",
                "sui-packages: https://github.com/MystenLabs/sui-packages",
            )
            .json(&body)
            .send()
            .map_err(GraphQLFetcherError::ReqwestError)?;
        let res_text = res.text().map_err(GraphQLFetcherError::ReqwestError)?;
        let res: PackageGraphQLResponse =
            serde_json::from_str(&res_text).map_err(GraphQLFetcherError::BadResponseError)?;
        Ok(res)
    }

    pub fn fetch_all(&mut self) -> Result<Vec<MovePackageWithMetadata>, GraphQLFetcherError> {
        let mut packages: Vec<MovePackageWithMetadata> = Vec::new();
        while self.has_next_page {
            let res = self.fetch_once()?;
            if let Some(data) = res.data {
                self.has_next_page = data.packages.page_info.has_next_page;
                self.cursor = data.packages.page_info.end_cursor;
                for node in data.packages.nodes {
                    let pkg_with_metadata: MovePackageWithMetadata = node.try_into()?;
                    println!("Fetched package: {}", pkg_with_metadata.package.id().to_string());
                    packages.push(pkg_with_metadata);
                }
            } else {
                if let Some(errors) = res.errors {
                    return Err(GraphQLFetcherError::GraphQLError(
                        errors
                            .iter()
                            .map(|e| e.message.clone())
                            .collect::<Vec<String>>()
                            .join(", "),
                    ));
                }
            }
        }
        Ok(packages)
    }

    pub fn parse_from_file(
        file_path: &str,
    ) -> Result<Vec<MovePackageWithMetadata>, GraphQLFetcherError> {
        let file = std::fs::File::open(file_path)
            .map_err(|_e| GraphQLFetcherError::GraphQLError("Failed to open file".to_string()))?;
        let reader = std::io::BufReader::new(file);
        let res: PackageGraphQLResponse =
            serde_json::from_reader(reader).map_err(GraphQLFetcherError::BadResponseError)?;
        let mut packages = Vec::new();
        for node in res.data.unwrap().packages.nodes {
            let pkg_with_metadata: MovePackageWithMetadata = node.try_into()?;
            println!("Fetched package: {}", pkg_with_metadata.package.id().to_string());
            packages.push(pkg_with_metadata);
        }
        Ok(packages)
    }
}

#[derive(Error, Debug)]
pub enum GraphQLFetcherError {
    #[error("Failed to send request")]
    ReqwestError(#[from] reqwest::Error),
    #[error("Failed to parse response")]
    BadResponseError(#[from] serde_json::Error),
    #[error("Server-side graphql errors: {0}")]
    GraphQLError(String),
    #[error("Failed to decode package bcs")]
    PackageBcsBase64DecodeError(#[from] base64::DecodeError),
    #[error("Previous transaction block not available because of pruned node. Address: {0}")]
    PreviousTransactionBlockNotAvailable(String),
    #[error("Failed to deserialize package for package id {0}")]
    PackageBcsDeserializeError(String),
}
