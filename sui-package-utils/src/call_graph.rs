use move_binary_format::file_format::{Bytecode, CompiledModule, FunctionHandle};
use serde::Serialize;
use std::collections::BTreeMap;
use sui_types::move_package::MovePackage;

pub enum CallGraphType {
    Original,
    // Linkage,
}

#[derive(Debug, Serialize)]
pub struct ModuleCallGraph {
    module_name: String,
    original_call_graph: BTreeMap<String, Vec<String>>,
    linkage_call_graph: BTreeMap<String, Vec<String>>,
}
#[derive(Debug, Serialize)]
pub struct PackageCallGraph {
    package_id: String,
    module_call_graphs: Vec<ModuleCallGraph>,
}

impl From<&MovePackage> for PackageCallGraph {
    fn from(pkg: &MovePackage) -> Self {
        let pkg_id = pkg.id().to_canonical_string(true);
        let mut package_call_graph = PackageCallGraph {
            package_id: pkg_id.clone(),
            module_call_graphs: Vec::new(),
        };
        for (module_name, module_bytes) in pkg.serialized_module_map() {
            let mut module_call_graph = ModuleCallGraph {
                module_name: module_name.clone(),
                original_call_graph: BTreeMap::new(),
                linkage_call_graph: BTreeMap::new(),
            };

            let module = CompiledModule::deserialize_with_defaults(module_bytes).unwrap();
            let function_defs = module.function_defs();
            for function_def in function_defs {
                let caller_handle = module.function_handle_at(function_def.function);
                let caller_name = module.identifier_at(caller_handle.name).to_string();
                module_call_graph
                    .original_call_graph
                    .insert(caller_name.clone(), Vec::new());
                module_call_graph
                    .linkage_call_graph
                    .insert(caller_name.clone(), Vec::new());
                let caller_graph_original: &mut Vec<String> = module_call_graph
                    .original_call_graph
                    .get_mut(&caller_name.to_string())
                    .unwrap();
                let _caller_graph_linkage: &mut Vec<String> = module_call_graph
                    .linkage_call_graph
                    .get_mut(&caller_name.to_string())
                    .unwrap();

                if let Some(code_unit) = &function_def.code {
                    let code = &code_unit.code;
                    for instruction in code {
                        match instruction {
                            Bytecode::Call(func_handle_index) => {
                                let callee_handle = module.function_handle_at(*func_handle_index);
                                caller_graph_original.push(get_full_function_name(
                                    &pkg,
                                    &module,
                                    &callee_handle,
                                    CallGraphType::Original,
                                ));
                            }
                            Bytecode::CallGeneric(func_instantiation_index) => {
                                let callee_instantiation =
                                    module.function_instantiation_at(*func_instantiation_index);
                                let callee_handle =
                                    module.function_handle_at(callee_instantiation.handle);
                                caller_graph_original.push(get_full_function_name(
                                    &pkg,
                                    &module,
                                    &callee_handle,
                                    CallGraphType::Original,
                                ));
                            }
                            _ => {}
                        }
                    }
                }
            }
            package_call_graph
                .module_call_graphs
                .push(module_call_graph);
        }
        package_call_graph
    }
}

fn get_full_function_name(
    _package: &MovePackage,
    module: &CompiledModule,
    func_handle: &FunctionHandle,
    call_graph_type: CallGraphType,
) -> String {
    let bytecode_module_handle = module.module_handle_at(func_handle.module);
    let bytecode_package_id = module.address_identifier_at(bytecode_module_handle.address);
    let bytecode_module_name = module.identifier_at(bytecode_module_handle.name);
    let bytecode_func_name = module.identifier_at(func_handle.name);

    let full_name = match call_graph_type {
        CallGraphType::Original => {
            format!(
                "{}::{}::{}",
                bytecode_package_id.to_canonical_string(true),
                bytecode_module_name.to_string(),
                bytecode_func_name.to_string()
            )
        }
    };
    full_name
}
