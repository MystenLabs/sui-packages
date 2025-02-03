module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::package_utils {
    struct CurrentVersion has copy, drop, store {
        dummy_field: bool,
    }

    struct CurrentPackage has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingPackage has copy, drop, store {
        dummy_field: bool,
    }

    struct PackageInfo has copy, drop, store {
        package: 0x2::object::ID,
        digest: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::package::UpgradeCap, arg2: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32) : 0x2::package::UpgradeTicket {
        set_authorized_digest(arg0, arg2);
        0x2::package::authorize_upgrade(arg1, 0x2::package::upgrade_policy(arg1), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::to_bytes(arg2))
    }

    public fun commit_upgrade(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::package::UpgradeCap, arg2: 0x2::package::UpgradeReceipt) : (0x2::object::ID, 0x2::object::ID) {
        0x2::package::commit_upgrade(arg1, arg2);
        let v0 = committed_package(arg0);
        set_commited_package(arg0, arg1);
        (v0, committed_package(arg0))
    }

    public fun assert_package_upgrade_cap<T0>(arg0: &0x2::package::UpgradeCap, arg1: u8, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v1) == 0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::get_address(&v0)))) && 0x2::package::upgrade_policy(arg0) == arg1 && 0x2::package::version(arg0) == arg2, 0);
    }

    public fun assert_version<T0: drop + store>(arg0: &0x2::object::UID, arg1: T0) {
        let v0 = CurrentVersion{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<CurrentVersion, T0>(arg0, v0), 1);
    }

    public fun authorized_digest(arg0: &0x2::object::UID) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32 {
        let v0 = PendingPackage{dummy_field: false};
        0x2::dynamic_field::borrow<PendingPackage, PackageInfo>(arg0, v0).digest
    }

    public fun committed_package(arg0: &0x2::object::UID) : 0x2::object::ID {
        let v0 = PendingPackage{dummy_field: false};
        0x2::dynamic_field::borrow<PendingPackage, PackageInfo>(arg0, v0).package
    }

    public fun current_digest(arg0: &0x2::object::UID) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32 {
        let v0 = CurrentPackage{dummy_field: false};
        0x2::dynamic_field::borrow<CurrentPackage, PackageInfo>(arg0, v0).digest
    }

    public fun current_package(arg0: &0x2::object::UID) : 0x2::object::ID {
        let v0 = CurrentPackage{dummy_field: false};
        0x2::dynamic_field::borrow<CurrentPackage, PackageInfo>(arg0, v0).package
    }

    public fun init_package_info<T0: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &0x2::package::UpgradeCap) {
        let v0 = 0x2::package::upgrade_package(arg2);
        let v1 = CurrentPackage{dummy_field: false};
        let v2 = PackageInfo{
            package : v0,
            digest  : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::default(),
        };
        0x2::dynamic_field::add<CurrentPackage, PackageInfo>(arg0, v1, v2);
        let v3 = PendingPackage{dummy_field: false};
        let v4 = PackageInfo{
            package : v0,
            digest  : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::default(),
        };
        0x2::dynamic_field::add<PendingPackage, PackageInfo>(arg0, v3, v4);
        let v5 = CurrentVersion{dummy_field: false};
        0x2::dynamic_field::add<CurrentVersion, T0>(arg0, v5, arg1);
    }

    public fun migrate_version<T0: drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        update_version_type<T0, T1>(arg0, arg1, arg2);
        update_package_info_from_pending(arg0);
    }

    fun set_authorized_digest(arg0: &mut 0x2::object::UID, arg1: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32) {
        let v0 = PendingPackage{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PendingPackage, PackageInfo>(arg0, v0).digest = arg1;
    }

    fun set_commited_package(arg0: &mut 0x2::object::UID, arg1: &0x2::package::UpgradeCap) {
        let v0 = PendingPackage{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PendingPackage, PackageInfo>(arg0, v0).package = 0x2::package::upgrade_package(arg1);
    }

    public fun type_of_version<T0: drop>(arg0: T0) : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    fun update_package_info_from_pending(arg0: &mut 0x2::object::UID) {
        let v0 = PendingPackage{dummy_field: false};
        let v1 = CurrentPackage{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<CurrentPackage, PackageInfo>(arg0, v1) = *0x2::dynamic_field::borrow<PendingPackage, PackageInfo>(arg0, v0);
    }

    fun update_version_type<T0: drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        let v0 = CurrentVersion{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<CurrentVersion, T0>(arg0, v0), 2);
        let v1 = CurrentVersion{dummy_field: false};
        0x2::dynamic_field::remove<CurrentVersion, T0>(arg0, v1);
        let v2 = 0x1::type_name::get<T1>();
        assert!(v2 != 0x1::type_name::get<T0>(), 3);
        assert!(0x1::ascii::into_bytes(0x1::type_name::get_module(&v2)) == b"version_control", 4);
        let v3 = CurrentVersion{dummy_field: false};
        0x2::dynamic_field::add<CurrentVersion, T1>(arg0, v3, arg2);
    }

    // decompiled from Move bytecode v6
}

