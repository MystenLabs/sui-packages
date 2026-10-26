module 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionMigrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun check_is_valid(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    public fun current(arg0: &Version) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &mut Version, arg2: &0x2::tx_context::TxContext) {
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_admin(arg0, arg2);
        let v0 = arg1.version;
        assert!(v0 <= 1, 1);
        if (v0 < 1) {
            arg1.version = 1;
            let v1 = VersionMigrated{
                from : v0,
                to   : 1,
            };
            0x2::event::emit<VersionMigrated>(v1);
        };
    }

    public fun package_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

