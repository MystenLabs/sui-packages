use std::fs;
use std::path::PathBuf;

use thiserror::Error;

use crate::bcs_json::BcsJsonSchema;
use crate::call_graph::PackageCallGraph;
use crate::common_types::MovePackageWithMetadata;
use crate::metadata::PackageMetadata;
use crate::package_id_io::PackagesDir;

#[derive(Error, Debug)]
pub enum PackageSaverError {
    #[error("Error saving package: {0}, {1}")]
    SaveError(String, String),
}

pub struct SaveArgs {
    pub bcs: bool,
    pub bytecode: bool,
    pub call_graph: bool,
    pub metadata: bool,
    pub move_code: bool,
    pub force: bool,
    pub packages_dir: PathBuf,
    pub move_decompiler_path: PathBuf,
}

pub fn save_package(
    args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), PackageSaverError> {
    save_bcs(args, pkg_with_metadata)?;
    save_code_files(args, pkg_with_metadata)?;
    save_call_graph(args, pkg_with_metadata)?;
    save_metadata(args, pkg_with_metadata)?;
    Ok(())
}

fn save_bcs(
    save_args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), PackageSaverError> {
    if !save_args.bcs {
        return Ok(());
    }
    let package_dir = create_package_dir(save_args, pkg_with_metadata)?;
    // create bcs.json
    let bcs_json_file = format!("{}/bcs.json", package_dir);
    if save_args.force || !std::path::Path::new(&bcs_json_file).exists() {
        let bcs_json_schema = BcsJsonSchema::from(&pkg_with_metadata.package);
        let bcs_json = serde_json::to_string_pretty(&bcs_json_schema).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error serializing bcs.json: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
        println!("Saving {}", bcs_json_file);
        fs::write(bcs_json_file, bcs_json).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error writing bcs.json: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }
    Ok(())
}

// saves bytecode and decompiled move code files
fn save_code_files(
    save_args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), PackageSaverError> {
    if !save_args.bytecode {
        return Ok(());
    }
    let package_dir = create_package_dir(save_args, pkg_with_metadata)?;

    // save bytecode and decompiled modules
    if save_args.bytecode {
        fs::create_dir_all(&format!("{}/bytecode_modules", package_dir)).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error creating bytecode_modules directory: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }

    if save_args.move_code {
        fs::create_dir_all(&format!("{}/decompiled_modules", package_dir)).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error creating decompiled_modules directory: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }
    if !save_args.bytecode && !save_args.move_code {
        return Ok(());
    }
    let pkg = &pkg_with_metadata.package;
    for (module_name, module_bytes) in pkg.serialized_module_map() {
        let bytecode_path = format!("{}/bytecode_modules/{}.mv", package_dir, module_name);
        if save_args.bytecode && (save_args.force || !std::path::Path::new(&bytecode_path).exists()) {
            println!("Saving {}", bytecode_path);
            fs::write(&bytecode_path, module_bytes).map_err(|e| {
                PackageSaverError::SaveError(
                    format!("Error writing bytecode file: {}", e),
                    pkg_with_metadata.package.id().to_canonical_string(true),
                )
            })?;
        }

        if save_args.move_code {
            let decompiled_path =
                format!("{}/decompiled_modules/{}.move", package_dir, module_name);
            if save_args.force || !std::path::Path::new(&decompiled_path).exists() {
                let output = std::process::Command::new(&save_args.move_decompiler_path)
                    .arg("--bytecode")
                    .arg(bytecode_path)
                    .output().map_err(|e| {
                        PackageSaverError::SaveError(
                            format!("Error running move-decompiler: {}", e),
                            pkg_with_metadata.package.id().to_canonical_string(true),
                        )
                    })?;
                println!("Saving {}", decompiled_path);
                fs::write(decompiled_path, output.stdout).map_err(|e| {
                    PackageSaverError::SaveError(
                        format!("Error writing decompiled file: {}", e),
                        pkg_with_metadata.package.id().to_canonical_string(true),
                    )
                })?;
            }
        }
    }
    Ok(())
}
fn save_call_graph(
    save_args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), PackageSaverError> {
    if !save_args.call_graph {
        return Ok(());
    }
    let package_dir = create_package_dir(save_args, pkg_with_metadata)?;

    // create call_graph.json
    let call_graph_json_file = format!("{}/call_graph.json", package_dir);
    if save_args.force || !std::path::Path::new(&call_graph_json_file).exists() {
        let call_graph_json = PackageCallGraph::from(&pkg_with_metadata.package);
        println!("Saving {}", call_graph_json_file);
        fs::write(
            call_graph_json_file,
            serde_json::to_string_pretty(&call_graph_json)
                .expect("could not serialize call_graph.json"),
        )
        .map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error writing call_graph.json: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }
    Ok(())
}

fn save_metadata(
    save_args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), PackageSaverError> {
    if !save_args.metadata {
        return Ok(());
    }
    let package_dir = create_package_dir(save_args, pkg_with_metadata)?;

    // create metadata.json
    let metadata_json_file = format!("{}/metadata.json", package_dir);
    if save_args.force || !std::path::Path::new(&metadata_json_file).exists() {
        let metadata = PackageMetadata::from(pkg_with_metadata);
        let metadata_json = serde_json::to_string_pretty(&metadata).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error serializing metadata.json: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
        println!("Saving {}", metadata_json_file);
        fs::write(metadata_json_file, metadata_json).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error writing metadata.json: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }
    Ok(())
}

fn create_package_dir(
    save_args: &SaveArgs,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<String, PackageSaverError> {
    let packages_dir = PackagesDir::new(save_args.packages_dir.clone());
    let package_dir =
        packages_dir.get_package_dir(&pkg_with_metadata.package.id().to_canonical_string(true));
    if !std::path::Path::new(&package_dir).exists() {
        fs::create_dir_all(&package_dir).map_err(|e| {
            PackageSaverError::SaveError(
                format!("Error creating package directory: {}", e),
                pkg_with_metadata.package.id().to_canonical_string(true),
            )
        })?;
    }
    Ok(package_dir)
}
