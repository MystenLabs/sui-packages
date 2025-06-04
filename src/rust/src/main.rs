use std::fs;
use std::io::{self, Read};
use std::path::{Path, PathBuf};
use sui_types::move_package::MovePackage;
use sui_types::SYSTEM_PACKAGE_ADDRESSES;

fn copy_dir_all(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> io::Result<()> {
    fs::create_dir_all(&dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let ty = entry.file_type()?;
        if ty.is_dir() {
            copy_dir_all(entry.path(), dst.as_ref().join(entry.file_name()))?;
        } else {
            fs::copy(entry.path(), dst.as_ref().join(entry.file_name()))?;
        }
    }
    Ok(())
}

fn traverse_and_apply<F>(dir: &Path, f: &mut F) -> io::Result<()>
where
    F: FnMut(&Path, &str),
{
    if dir.is_dir() {
        for entry in fs::read_dir(dir)? {
            let entry = entry?;
            let path = entry.path();
            if path.is_dir() {
                traverse_and_apply(&path, f)?;
            } else if path.is_file()
                && path
                    .file_stem()
                    .is_some_and(|x| x.to_string_lossy() == "bcs")
            {
                println!("found bcs.json");
                let mut file_content = String::new();
                let mut file = fs::File::open(&path)?;
                file.read_to_string(&mut file_content)?;
                f(&path, &file_content);
            }
        }
    }
    Ok(())
}

fn path_from_package_name(_root_dir: &Path, package_name: &str) -> PathBuf {
    let mut path = PathBuf::from("..");
    let (parent_dir, package_dir) = package_name.split_at(4);
    path.push(parent_dir);
    path.push(package_dir);
    path
}

fn valid_pkg_name_for_id(package_id: &str) -> String {
    let valid_ident_pkg_name = package_id.to_string().split_off(2);
    format!("p_{}", valid_ident_pkg_name)
}

fn generate_move_toml(
    dir_name: &Path,
    package_dir: &Path,
    package: &MovePackage,
) -> io::Result<()> {
    let package_name = package.id().to_canonical_string(true);
    let valid_ident_pkg_name = valid_pkg_name_for_id(&package_name);
    let mut toml = String::new();
    toml.push_str("[package]\n");
    toml.push_str(&format!("name = \"{}\"\n", valid_ident_pkg_name));
    toml.push_str("[addresses]\n");

    toml.push_str("[dependencies]\n");
    let mut include_sui = false;
    for (og_id, info) in package.linkage_table().iter() {
        if SYSTEM_PACKAGE_ADDRESSES.contains(og_id) {
            include_sui = true;
            continue;
        }
        let pkg_id = &info.upgraded_id.to_canonical_string(true);
        let path = path_from_package_name(dir_name, &pkg_id);
        let dep_name = valid_pkg_name_for_id(pkg_id);
        toml.push_str(&format!(
            "{} = {{local = \"{}\" }}\n",
            dep_name,
            path.to_str().unwrap()
        ));
    }
    if include_sui {
        //toml.push_str("Sui = { git = \"https://github.com/MystenLabs/sui.git\", subdir = \"crates/sui-framework/packages/sui-framework\", rev = \"framework/testnet\" }");
        // use local sui dep because it makes build/test much faster. note that this is making strong assumptions about the location of the sui dir compared to the Move package dir
        toml.push_str(
            "Sui = { local = \"../../../../../sui/crates/sui-framework/packages/sui-framework\" }",
        );
    }
    /*println!(
        "write TOML to {:?}:-----\n{}\n----------",
        package_dir.join("Move.toml"),
        toml
    );*/
    println!(
        r#"To test this package, use the following Move.toml:
[package]
name = "tester"

[dependencies]
# note: makes sure this path is correct for the location of your Move.toml
# these paths assume you place it in a sibling directory of `sui` and `sui-packages`
Sui = {{ local = "../sui/crates/sui-framework/packages/sui-framework" }}
# note: makes sure this path is correct for the location of your Move.toml
{} = {{ local = "../sui-packages/packages/mainnet/{}/{}" }}
# end of Move.toml

The Move source code associated with this Move.toml should look something like:
module tester::tester;
use {}::{};
"#,
        valid_ident_pkg_name,
        package_name[0..4].to_string(),
        package_name[4..].to_string(),
        package_name,
        package.serialized_module_map().keys().next().unwrap()
    );
    std::fs::write(package_dir.join("Move.toml"), toml)?;
    Ok(())
}

pub fn generate_build_dir(current_dir: &Path, package: &MovePackage) -> io::Result<()> {
    let dst_path = current_dir.join("build").join("bytecode_dep");
    let src_path = current_dir.join("bytecode_modules");

    // println!(
    //     "copying from {:?} to {:?}, create: {:?}",
    //     src_path,
    //     dst_path.join("bytecode_modules"),
    //     dst_path,
    // );

    fs::create_dir_all(&dst_path)?;
    copy_dir_all(src_path, dst_path.join("bytecode_modules"))?;

    Ok(())
}

fn main() -> io::Result<()> {
    let directory = Path::new(".");

    // Define a closure to be called on each file with its content
    let mut print_file_content = |path: &Path, content: &str| {
        if !path
            .file_stem()
            .is_some_and(|x| x.to_string_lossy() == "bcs")
        {
            return;
        }

        let package_dir = path.parent().unwrap();

        // if package_dir.join("Move.toml").exists() {
        //     return;
        // }

        let package: MovePackage = serde_json::from_str(content).unwrap();
        generate_move_toml(&directory, &package_dir, &package).unwrap();
        generate_build_dir(&package_dir, &package).unwrap();
    };

    traverse_and_apply(directory, &mut print_file_content).unwrap();
    println!("Done processing packages");

    Ok(())
}
