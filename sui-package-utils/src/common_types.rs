use serde::{Deserialize, Serialize};
use sui_types::move_package::MovePackage;

#[derive(Eq, PartialEq, Debug, Clone, Deserialize, Serialize, Hash)]
pub struct MovePackageWithMetadata {
    pub package: MovePackage,
    pub epoch: u64,
    pub checkpoint: u64,
    pub transaction_digest: String,
    pub sender: Option<String>,
}
