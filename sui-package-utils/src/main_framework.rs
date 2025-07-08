use std::error::Error;
use std::path::PathBuf;

use clap::Parser;
use sui_package_utils::graphql::PackageGraphQLFetcher;
use sui_package_utils::package_saver::{save_package, SaveArgs};

#[derive(Parser)]
struct Args {
    #[arg(long)]
    move_decompiler_path: PathBuf,
    #[arg(long)]
    packages_dir: PathBuf,
    #[arg(long, default_value = "true")]
    force: bool,
}
fn main() -> Result<(), Box<dyn Error>> {
    let cli_args = Args::parse();
    let framework_packages = vec![
        "0x0000000000000000000000000000000000000000000000000000000000000001",
        "0x0000000000000000000000000000000000000000000000000000000000000002",
        "0x0000000000000000000000000000000000000000000000000000000000000003",
        "0x000000000000000000000000000000000000000000000000000000000000000b",
        "0x000000000000000000000000000000000000000000000000000000000000dee9",
    ];
    let save_args = SaveArgs {
        bcs: true,
        bytecode: true,
        call_graph: true,
        metadata: true,
        move_code: true,
        force: cli_args.force,
        packages_dir: cli_args.packages_dir.clone(),
        move_decompiler_path: cli_args.move_decompiler_path,
    };
    for pkg in framework_packages {
        let pkg_with_metadata = PackageGraphQLFetcher::fetch_single_package(&pkg)?;
        save_package(&save_args, &pkg_with_metadata)?;
    }
    Ok(())
}
