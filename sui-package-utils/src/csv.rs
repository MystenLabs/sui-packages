use base64::prelude::*;
use serde::Deserialize;
use sui_types::move_package::MovePackage;

use crate::common_types::MovePackageWithMetadata;

/* Struct used to read a csv file generated from Snowflake with the following query:

select
  pkg.package_id,
  pkg.package_version,
  pkg.checkpoint,
  pkg.epoch,
  pkg.bcs,
  pkg.transaction_digest,
  tp.sender
from
  move_package_parquet2 pkg
join
  transaction_parquet tp
on
  pkg.timestamp_ms = tp.timestamp_ms and pkg.transaction_digest = tp.transaction_digest
where
  tp.transaction_kind = 'ProgrammableTransaction' and
  pkg.bcs is not null and pkg.bcs <> ''
order by
  pkg.checkpoint,
  pkg.package_id

This reads up to checkpoint 150317860
After that, we used GraphQL to get the bcs for all packages up to checkpoint 150317860
*/
#[derive(Debug, Deserialize)]
pub struct PackageBcsWithCreationInfo {
    #[serde(rename = "PACKAGE_ID")]
    pub package_id: String,
    #[serde(rename = "PACKAGE_VERSION")]
    pub package_version: u64,
    #[serde(rename = "CHECKPOINT")]
    pub checkpoint: u64,
    #[serde(rename = "EPOCH")]
    pub epoch: u64,
    #[serde(rename = "BCS")]
    pub bcs: String,
    #[serde(rename = "TRANSACTION_DIGEST")]
    pub transaction_digest: String,
    #[serde(rename = "SENDER")]
    pub sender: Option<String>,
}

impl Into<MovePackageWithMetadata> for PackageBcsWithCreationInfo {
    fn into(self) -> MovePackageWithMetadata {
        let bytes = BASE64_STANDARD.decode(&self.bcs).unwrap();
        let pkg: MovePackage = bcs::from_bytes(&bytes).unwrap();
        MovePackageWithMetadata {
            package: pkg,
            epoch: self.epoch,
            checkpoint: self.checkpoint,
            transaction_digest: self.transaction_digest,
            sender: self.sender.clone(),
        }
    }
}
