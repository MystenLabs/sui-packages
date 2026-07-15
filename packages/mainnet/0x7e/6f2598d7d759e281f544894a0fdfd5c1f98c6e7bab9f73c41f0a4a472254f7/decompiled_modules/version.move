module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version {
    struct VersionMigrated has copy, drop {
        object_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public fun assert_version_matches(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun migrate(arg0: &mut u64, arg1: 0x2::object::ID) {
        let v0 = *arg0;
        assert!(v0 < 1, 1);
        *arg0 = 1;
        let v1 = VersionMigrated{
            object_id   : arg1,
            old_version : v0,
            new_version : 1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<VersionMigrated>(v1);
    }

    // decompiled from Move bytecode v7
}

