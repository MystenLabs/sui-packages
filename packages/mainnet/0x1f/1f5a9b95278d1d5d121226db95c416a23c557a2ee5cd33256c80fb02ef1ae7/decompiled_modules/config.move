module 0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::config {
    struct PackageVersion has store, key {
        id: 0x2::object::UID,
        min_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        package_version_id: 0x2::object::ID,
    }

    struct UpdatePackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun checked_package_version(arg0: &PackageVersion) {
        assert!(1 >= arg0.min_version, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PackageVersion{
            id          : 0x2::object::new(arg0),
            min_version : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PackageVersion>(v1);
        let v2 = InitConfigEvent{
            admin_cap_id       : 0x2::object::id<AdminCap>(&v0),
            package_version_id : 0x2::object::id<PackageVersion>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut PackageVersion, arg2: u64) {
        checked_package_version(arg1);
        arg1.min_version = arg2;
        let v0 = UpdatePackageVersionEvent{
            new_version : arg2,
            old_version : arg1.min_version,
        };
        0x2::event::emit<UpdatePackageVersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

