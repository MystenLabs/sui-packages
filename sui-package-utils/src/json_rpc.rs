use thiserror::Error;

#[derive(Error, Debug)]
pub enum JsonRpcError {
    #[error("Failed to send request")]
    ReqwestError(#[from] reqwest::Error),
    #[error("Failed to parse response")]
    BadResponseError,
    #[error("Server-side jsonrpc errors: {0}")]
    JsonRpcError(String),
}

#[derive(Debug)]
pub struct TransactionMetadata {
    pub transaction_digest: String,
    pub sender: String,
    pub checkpoint: u64,
}

pub fn get_package_creation_transaction(object_id: &str) -> Result<String, JsonRpcError> {
    let client = reqwest::blocking::Client::new();
    let body = format!(
        r#"{{
      "id": 1,
      "jsonrpc": "2.0",
      "method": "sui_getObject",
      "params": [
        "{}",
        {{
          "showBcs": false,
          "showContent": false,
          "showDisplay": false,
          "showOwner": true,
          "showPreviousTransaction": true,
          "showType": true
        }}
      ]
    }}"#,
        object_id
    );
    let res = client
        .post("https://fullnode.mainnet.sui.io/")
        .header("Content-Type", "application/json")
        .header(
            "User-Agent",
            "sui-packages: https://github.com/MystenLabs/sui-packages",
        )
        .body(body)
        .send()
        .map_err(JsonRpcError::ReqwestError)?;
    let res_text = res.text().map_err(|_| JsonRpcError::BadResponseError)?;
    let res_json: serde_json::Value =
        serde_json::from_str(&res_text).map_err(|_| JsonRpcError::BadResponseError)?;
    let transaction_digest = res_json["result"]["data"]["previousTransaction"]
        .as_str()
        .ok_or(JsonRpcError::JsonRpcError(
            "Transaction digest not found".to_string(),
        ))?;
    Ok(transaction_digest.to_string())
}

pub fn get_transaction_metadata(
    transaction_digest: &str,
) -> Result<TransactionMetadata, JsonRpcError> {
    let client = reqwest::blocking::Client::new();
    let body = format!(
        r#"{{
      "id": 1,
      "jsonrpc": "2.0",
      "method": "sui_getTransactionBlock",
      "params": [
        "{}",
        {{
          "showInput": true
        }}
      ]
    }}"#,
        transaction_digest
    );
    let res = client
        .post("https://fullnode.mainnet.sui.io/")
        .header("Content-Type", "application/json")
        .header(
            "User-Agent",
            "sui-packages: https://github.com/MystenLabs/sui-packages",
        )
        .body(body)
        .send()
        .map_err(JsonRpcError::ReqwestError)?;
    let res_text = res.text().map_err(|_| JsonRpcError::BadResponseError)?;
    let res_json: serde_json::Value =
        serde_json::from_str(&res_text).map_err(|_| JsonRpcError::BadResponseError)?;
    let sender = res_json["result"]["transaction"]["data"]["sender"]
        .as_str()
        .ok_or(JsonRpcError::JsonRpcError("Sender not found".to_string()))?;
    let checkpoint_str =
        res_json["result"]["checkpoint"]
            .as_str()
            .ok_or(JsonRpcError::JsonRpcError(
                "Checkpoint not found".to_string(),
            ))?;
    let checkpoint = checkpoint_str
        .parse::<u64>()
        .map_err(|_| JsonRpcError::JsonRpcError(format!("Bad checkpoint: {}", checkpoint_str)))?;
    let transaction_metadata = TransactionMetadata {
        transaction_digest: transaction_digest.to_string(),
        sender: sender.to_string(),
        checkpoint,
    };
    Ok(transaction_metadata)
}
