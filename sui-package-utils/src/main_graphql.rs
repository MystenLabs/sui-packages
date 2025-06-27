
use std::error::Error;
use std::path::PathBuf;

use clap::Parser;
use sui_package_utils::graphql::PackageGraphQLFetcher;
use sui_package_utils::package_id_io::PackagesDir;
use sui_package_utils::package_saver::{SaveArgs, save_package};

#[derive(Parser)]
struct Args {
    #[arg(long)]
    move_decompiler_path: PathBuf,
    #[arg(long)]
    packages_dir: PathBuf,
    #[arg(long)]
    initial_checkpoint: Option<u64>,
    #[arg(long, default_value = "false")]
    force: bool,
}
fn main() -> Result<(), Box<dyn Error>> {
    let cli_args = Args::parse();
    let packages_dir = PackagesDir::new(cli_args.packages_dir.clone());
    let initial_checkpoint = if cli_args.initial_checkpoint.is_some() {
        cli_args.initial_checkpoint.unwrap()
    } else {
        packages_dir.get_latest_checkpoint()?
    };
    println!("Fetching packages from graphql starting from checkpoint {}", initial_checkpoint);

    let mut fetcher = PackageGraphQLFetcher::new(initial_checkpoint, None);
    let res = fetcher.fetch_all()?;
    let save_args = SaveArgs {
        bcs: true,
        bytecode: true,
        call_graph: false,
        metadata: true,
        move_code: true,
        force: cli_args.force,
        packages_dir: packages_dir.get_prefix(),
        move_decompiler_path: cli_args.move_decompiler_path,
    };
    for pkg in res {
        save_package(&save_args, &pkg)?;
    }
    Ok(())
}
