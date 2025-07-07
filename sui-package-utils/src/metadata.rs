use serde::{Deserialize, Serialize};
use sui_types::move_package::MovePackage;

use crate::common_types::MovePackageWithMetadata;
use crate::csv::PackageBcsWithCreationInfo;

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PackageMetadata {
    pub id: String,
    pub original_package_id: String,
    pub version: u64,
    pub sender: Option<String>,
    pub transaction_digest: String,
    pub checkpoint: u64,
}

impl From<&MovePackageWithMetadata> for PackageMetadata {
    fn from(pkg_with_metadata: &MovePackageWithMetadata) -> Self {
        PackageMetadata {
            id: pkg_with_metadata.package.id().to_canonical_string(true),
            original_package_id: pkg_with_metadata
                .package
                .original_package_id()
                .to_canonical_string(true),
            version: pkg_with_metadata.package.version().value(),
            sender: pkg_with_metadata.sender.clone(),
            transaction_digest: pkg_with_metadata.transaction_digest.to_string(),
            checkpoint: pkg_with_metadata.checkpoint,
        }
    }
}

pub fn move_package_to_metadata_json(
    pkg: &MovePackage,
    record: &PackageBcsWithCreationInfo,
) -> String {
    let metadata = PackageMetadata {
        id: pkg.id().to_canonical_string(true),
        original_package_id: pkg.original_package_id().to_canonical_string(true),
        version: pkg.version().value(),
        sender: record.sender.clone(),
        transaction_digest: record.transaction_digest.to_string(),
        checkpoint: record.checkpoint,
    };
    serde_json::to_string_pretty(&metadata).expect("could not serialize metadata.json")
}
