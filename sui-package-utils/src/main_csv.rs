use clap::{Parser, ValueEnum};
use csv;

use std::error::Error;
use std::path::PathBuf;

use sui_package_utils::common_types::MovePackageWithMetadata;
use sui_package_utils::csv::PackageBcsWithCreationInfo;
use sui_package_utils::package_saver::{save_package, SaveArgs};

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

impl Into<SaveArgs> for &Args {
    fn into(self) -> SaveArgs {
        SaveArgs {
            bcs: true,
            bytecode: true,
            call_graph: true,
            metadata: true,
            move_code: true,
            force: self.force,
            packages_dir: self.packages_dir.clone(),
            move_decompiler_path: self.move_decompiler_path.clone(),
        }
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Args::parse();
    process_csv_records(&args)?;
    Ok(())
}

fn process_csv_records(cli_args: &Args) -> Result<(), Box<dyn Error>> {
    let save_args: SaveArgs = cli_args.into();
    let mut rdr = csv::Reader::from_path(&cli_args.package_bcs_csv)?;
    for result in rdr.deserialize::<PackageBcsWithCreationInfo>() {
        let pkg_with_metadata: MovePackageWithMetadata = result?.into();
        let id = pkg_with_metadata.package.id();
        println!("Processing {}", id.to_canonical_string(true));
        save_package(&save_args, &pkg_with_metadata)?;
    }
    Ok(())
}
