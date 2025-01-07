module 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info {
    struct PACKAGE_INFO has drop {
        dummy_field: bool,
    }

    struct PackageInfo has key {
        id: 0x2::object::UID,
        display: 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::display::PackageDisplay,
        upgrade_cap_id: 0x2::object::ID,
        package_address: address,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        git_versioning: 0x2::table::Table<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>,
    }

    public fun id(arg0: &PackageInfo) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new(arg0: &mut 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : PackageInfo {
        let v0 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v0) != @0x0, 1);
        let v1 = 0x2::package::upgrade_package(arg0);
        PackageInfo{
            id              : 0x2::object::new(arg1),
            display         : 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::display::default(0x1::string::utf8(b"Package")),
            upgrade_cap_id  : 0x2::object::id<0x2::package::UpgradeCap>(arg0),
            package_address : 0x2::object::id_to_address(&v1),
            metadata        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            git_versioning  : 0x2::table::new<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>(arg1),
        }
    }

    public fun transfer(arg0: PackageInfo, arg1: address) {
        0x2::transfer::transfer<PackageInfo>(arg0, arg1);
    }

    fun init(arg0: PACKAGE_INFO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE_INFO>(arg0, arg1);
    }

    public fun package_address(arg0: &PackageInfo) : address {
        arg0.package_address
    }

    public fun remove_custom_metadata<T0: copy + drop + store, T1: store>(arg0: &mut PackageInfo, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun set_custom_metadata<T0: copy + drop + store, T1: store>(arg0: &mut PackageInfo, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun set_display(arg0: &mut PackageInfo, arg1: 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::display::PackageDisplay) {
        0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::display::encode_label(&mut arg1, 0x2::address::to_string(arg0.package_address));
        arg0.display = arg1;
    }

    public fun set_git_versioning(arg0: &mut PackageInfo, arg1: u64, arg2: 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo) {
        assert!(!0x2::table::contains<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>(&arg0.git_versioning, arg1), 3);
        0x2::table::add<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>(&mut arg0.git_versioning, arg1, arg2);
    }

    public fun set_metadata(arg0: &mut PackageInfo, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1, arg2);
    }

    public fun unset_git_versioning(arg0: &mut PackageInfo, arg1: u64) : 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo {
        assert!(0x2::table::contains<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>(&arg0.git_versioning, arg1), 2);
        0x2::table::remove<u64, 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git::GitInfo>(&mut arg0.git_versioning, arg1)
    }

    public fun unset_metadata(arg0: &mut PackageInfo, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1);
    }

    public fun upgrade_cap_id(arg0: &PackageInfo) : 0x2::object::ID {
        arg0.upgrade_cap_id
    }

    // decompiled from Move bytecode v6
}

