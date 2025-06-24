use clap::{Parser, ValueEnum};
use csv;

use serde_json;
use std::error::Error;
use std::fs;
use std::path::PathBuf;

use sui_package_utils::bcs_json::BcsJsonSchema;
use sui_package_utils::call_graph::PackageCallGraph;
use sui_package_utils::common_types::MovePackageWithMetadata;
use sui_package_utils::csv::PackageBcsWithCreationInfo;
use sui_package_utils::metadata::PackageMetadata;
use sui_package_utils::package_id_io::PackagesDir;

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
enum Network {
    Mainnet,
    Testnet,
}

#[derive(Parser)]
struct Args {
    #[arg(long)]
    package_bcs_csv: PathBuf,
    #[arg(long)]
    packages_dir: PathBuf,
    #[arg(long)]
    move_decompiler_path: PathBuf,
    #[arg(long, default_value = "false")]
    force: bool,
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Args::parse();
    process_csv_records(&args, save_package)?;
    Ok(())
}

fn process_csv_records(
    cli_args: &Args,
    func: fn(&Args, &MovePackageWithMetadata) -> Result<(), Box<dyn Error>>,
) -> Result<(), Box<dyn Error>> {
    let mut rdr = csv::Reader::from_path(&cli_args.package_bcs_csv)?;
    for result in rdr.deserialize::<PackageBcsWithCreationInfo>() {
        let pkg_with_metadata: MovePackageWithMetadata = result?.into();
        let id = pkg_with_metadata.package.id();
        println!("Processing {}", id.to_canonical_string(true));
        func(cli_args, &pkg_with_metadata)?;
    }
    Ok(())
}

fn save_package(
    cli_args: &Args,
    pkg_with_metadata: &MovePackageWithMetadata,
) -> Result<(), Box<dyn Error>> {
    let packages_dir = PackagesDir::new(cli_args.packages_dir.clone());
    let package_dir =
        packages_dir.get_package_dir(&pkg_with_metadata.package.id().to_canonical_string(true));
    fs::create_dir_all(&package_dir)?;

    // create bcs.json
    let bcs_json_file = format!("{}/bcs.json", package_dir);
    if cli_args.force || !std::path::Path::new(&bcs_json_file).exists() {
        let bcs_json_schema = BcsJsonSchema::from(&pkg_with_metadata.package);
        let bcs_json = serde_json::to_string_pretty(&bcs_json_schema)?;
        println!("Saving {}", bcs_json_file);
        fs::write(bcs_json_file, bcs_json)?;
    }

    // create call_graph.json
    let call_graph_json_file = format!("{}/call_graph.json", package_dir);
    if cli_args.force || !std::path::Path::new(&call_graph_json_file).exists() {
        let call_graph_json = PackageCallGraph::from(&pkg_with_metadata.package);
        println!("Saving {}", call_graph_json_file);
        fs::write(
            call_graph_json_file,
            serde_json::to_string_pretty(&call_graph_json)
                .expect("could not serialize call_graph.json"),
        )?;
    }

    // create metadata.json
    let metadata_json_file = format!("{}/metadata.json", package_dir);
    if cli_args.force || !std::path::Path::new(&metadata_json_file).exists() {
        let metadata = PackageMetadata::from(pkg_with_metadata);
        let metadata_json = serde_json::to_string_pretty(&metadata)?;
        println!("Saving {}", metadata_json_file);
        fs::write(metadata_json_file, metadata_json)?;
    }

    // save bytecode and decompiled modules
    fs::create_dir_all(&format!("{}/bytecode_modules", package_dir))?;
    fs::create_dir_all(&format!("{}/decompiled_modules", package_dir))?;
    let pkg = &pkg_with_metadata.package;
    for (module_name, module_bytes) in pkg.serialized_module_map() {
        let bytecode_path = format!("{}/bytecode_modules/{}.mv", package_dir, module_name);
        if cli_args.force || !std::path::Path::new(&bytecode_path).exists() {
            println!("Saving {}", bytecode_path);
            fs::write(&bytecode_path, module_bytes)?;
        }
        let decompiled_path = format!("{}/decompiled_modules/{}.move", package_dir, module_name);
        if cli_args.force || !std::path::Path::new(&decompiled_path).exists() {
            let output = std::process::Command::new(&cli_args.move_decompiler_path)
                .arg("--bytecode")
                .arg(bytecode_path)
                .output()?;
            println!("Saving {}", decompiled_path);
            fs::write(decompiled_path, output.stdout)?;
        }
    }
    Ok(())
}
