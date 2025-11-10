use base64::{engine::general_purpose::STANDARD as BASE64_STANDARD, Engine as _};
use move_binary_format::file_format::{
    CompiledModule, DatatypeHandleIndex, SignatureToken, Visibility,
};
use move_core_types::account_address::AccountAddress;
use move_core_types::identifier::IdentStr;
use serde::{Deserialize, Serialize};
use std::collections::BTreeMap;
use sui_types::base_types::ObjectID;
use sui_types::move_package::MovePackage;
use sui_types::move_package::{TypeOrigin, UpgradeInfo};

#[derive(Debug, Deserialize, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct BcsJsonSchema {
    data_type: String,
    id: String,
    version: u64,
    module_map: BTreeMap<String, String>,
    type_origin_table: Vec<TypeOrigin>,
    linkage_table: BTreeMap<ObjectID, UpgradeInfo>,
    function_map: BTreeMap<String, BTreeMap<String, BcsFunctionEntry>>,
}

#[derive(Debug, Deserialize, PartialEq, Serialize)]
pub struct BcsFunctionEntry {
    visibility: String,
    is_entry: bool,
    params: Vec<String>,
    #[serde(rename = "return")]
    return_: Vec<String>,
}
impl BcsJsonSchema {
    pub fn get_module_map(&self) -> &BTreeMap<String, String> {
        &self.module_map
    }
}

impl From<&MovePackage> for BcsJsonSchema {
    fn from(pkg: &MovePackage) -> Self {
        let base64_map = pkg
            .serialized_module_map()
            .into_iter()
            .map(|(k, v)| (k.clone(), BASE64_STANDARD.encode(v)))
            .collect();
        let pkg_modules: BTreeMap<String, CompiledModule> = pkg
            .serialized_module_map()
            .into_iter()
            .map(|(k, v)| {
                (
                    k.clone(),
                    CompiledModule::deserialize_with_defaults(v).unwrap(),
                )
            })
            .collect::<BTreeMap<String, CompiledModule>>();
        let function_map: BTreeMap<String, BTreeMap<String, BcsFunctionEntry>> = pkg_modules
            .iter()
            .map(|(k, v)| (k.clone(), move_module_to_bcs_function_map(&v)))
            .collect::<BTreeMap<String, BTreeMap<String, BcsFunctionEntry>>>();
        BcsJsonSchema {
            data_type: String::from("package"),
            id: pkg.id().to_string(),
            version: pkg.version().value(),
            module_map: base64_map,
            type_origin_table: pkg.type_origin_table().clone(),
            linkage_table: pkg.linkage_table().clone(),
            function_map: function_map,
        }
    }
}

pub fn move_module_to_bcs_function_map(
    module: &CompiledModule,
) -> BTreeMap<String, BcsFunctionEntry> {
    let mut function_map: BTreeMap<String, BcsFunctionEntry> = BTreeMap::new();
    for function_def in module.function_defs() {
        let handle_index = function_def.function;
        let function_handle = module.function_handle_at(handle_index);
        let function_name = module.identifier_at(function_handle.name).to_string();
        let function_params = module.signature_at(function_handle.parameters);
        let function_return = module.signature_at(function_handle.return_);
        let function_entry = BcsFunctionEntry {
            visibility: (match function_def.visibility {
                Visibility::Public => "PUBLIC",
                Visibility::Private => "PRIVATE",
                Visibility::Friend => "FRIEND",
            })
            .to_string(),
            is_entry: function_def.is_entry,
            params: function_params
                .0
                .iter()
                .map(|p| format_signature_token(module, p))
                .collect(),
            return_: function_return
                .0
                .iter()
                .map(|r| format_signature_token(module, r))
                .collect(),
        };
        function_map.insert(function_name, function_entry);
    }
    function_map
}

// TODO remove - copied from move-bytecode-utils/src/lib.rs because I want canonical addresses instead of short
fn resolve_struct(
    module: &CompiledModule,
    sidx: DatatypeHandleIndex,
) -> (&AccountAddress, &IdentStr, &IdentStr) {
    let shandle = module.datatype_handle_at(sidx);
    let mhandle = module.module_handle_at(shandle.module);
    let address = module.address_identifier_at(mhandle.address);
    let module_name = module.identifier_at(mhandle.name);
    let struct_name = module.identifier_at(shandle.name);
    (address, module_name, struct_name)
}

fn format_signature_token(module: &CompiledModule, t: &SignatureToken) -> String {
    match t {
        SignatureToken::Bool => "bool".to_string(),
        SignatureToken::U8 => "u8".to_string(),
        SignatureToken::U16 => "u16".to_string(),
        SignatureToken::U32 => "u32".to_string(),
        SignatureToken::U64 => "u64".to_string(),
        SignatureToken::U128 => "u128".to_string(),
        SignatureToken::U256 => "u256".to_string(),
        SignatureToken::Address => "address".to_string(),
        SignatureToken::Signer => "signer".to_string(),
        SignatureToken::Vector(inner) => {
            format!("vector<{}>", format_signature_token(module, inner))
        }
        SignatureToken::Reference(inner) => format!("&{}", format_signature_token(module, inner)),
        SignatureToken::MutableReference(inner) => {
            format!("&mut {}", format_signature_token(module, inner))
        }
        SignatureToken::TypeParameter(i) => format!("T{}", i),

        SignatureToken::Datatype(idx) => format_signature_token_struct(module, *idx, &[]),
        SignatureToken::DatatypeInstantiation(inst) => {
            let (idx, ty_args) = &**inst;
            format_signature_token_struct(module, *idx, ty_args)
        }
    }
}

fn format_signature_token_struct(
    module: &CompiledModule,
    sidx: DatatypeHandleIndex,
    ty_args: &[SignatureToken],
) -> String {
    let (address, module_name, struct_name) = resolve_struct(module, sidx);
    let s;
    let ty_args_string = if ty_args.is_empty() {
        ""
    } else {
        s = format!(
            "<{}>",
            ty_args
                .iter()
                .map(|t| format_signature_token(module, t))
                .collect::<Vec<_>>()
                .join(", ")
        );
        &s
    };
    format!(
        "0x{}::{}::{}{}",
        address.to_canonical_string(false),
        module_name,
        struct_name,
        ty_args_string
    )
}
