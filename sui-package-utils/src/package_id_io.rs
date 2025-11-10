use crate::metadata::PackageMetadata;
use regex::Regex;
use std::fs;
use std::io::Error as IOError;
use std::path::PathBuf;

pub struct PackagesDir {
    prefix: PathBuf,
}

const LAST_62_REGEX: &str = r"/[0-9a-f]{62}$";

impl PackagesDir {
    pub fn new(prefix: PathBuf) -> Self {
        Self { prefix }
    }
    pub fn get_prefix(self: &PackagesDir) -> PathBuf {
        self.prefix.clone()
    }
    pub fn get_package_dir(self: &PackagesDir, id: &str) -> String {
        let first_4 = &id[0..4];
        let last_62 = &id[4..id.len()];
        format!("{}/{}/{}", self.prefix.to_str().unwrap(), first_4, last_62)
    }

    pub fn get_package_directories(self: &PackagesDir) -> Result<Vec<PathBuf>, IOError> {
        let mut package_directories = Vec::new();
        let regex = Regex::new(LAST_62_REGEX).unwrap();
        // list first level subdirectories of prefix starting with "0x"
        let first_level_dirs = fs::read_dir(&self.prefix)?;
        for first_level_dir in first_level_dirs {
            let first_level_entry = first_level_dir?;
            let first_level_path = first_level_entry.path();
            if first_level_path.is_dir()
                && first_level_path.file_name().is_some()
                && first_level_path
                    .file_name()
                    .unwrap()
                    .to_str()
                    .unwrap()
                    .starts_with("0x")
            {
                let second_level_dirs = fs::read_dir(first_level_path)?;
                for second_level_dir in second_level_dirs {
                    let second_level_entry = second_level_dir?;
                    let second_level_path = second_level_entry.path();
                    if second_level_path.is_dir()
                        && regex.is_match(second_level_path.to_str().unwrap())
                    {
                        package_directories.push(second_level_path);
                    }
                }
            }
        }
        Ok(package_directories)
    }

    pub fn get_latest_checkpoint(self: &PackagesDir) -> Result<u64, IOError> {
        let mut latest_checkpoint = 0;
        let regex = Regex::new(LAST_62_REGEX).unwrap();
        // list first level subdirectories of prefix starting with "0x"
        let first_level_dirs = fs::read_dir(&self.prefix)?;
        for first_level_dir in first_level_dirs {
            let first_level_entry = first_level_dir?;
            let first_level_path = first_level_entry.path();
            if first_level_path.is_dir()
                && first_level_path.file_name().is_some()
                && first_level_path
                    .file_name()
                    .unwrap()
                    .to_str()
                    .unwrap()
                    .starts_with("0x")
            {
                let second_level_dirs = fs::read_dir(first_level_path)?;
                for second_level_dir in second_level_dirs {
                    let second_level_entry = second_level_dir?;
                    let second_level_path = second_level_entry.path();
                    if second_level_path.is_dir()
                        && regex.is_match(second_level_path.to_str().unwrap())
                    {
                        let metadata_file =
                            fs::read_to_string(second_level_path.join("metadata.json"))?;
                        let metadata: PackageMetadata = serde_json::from_str(&metadata_file)?;
                        if metadata.checkpoint > latest_checkpoint {
                            latest_checkpoint = metadata.checkpoint;
                        }
                    }
                }
            }
        }
        Ok(latest_checkpoint)
    }
}
