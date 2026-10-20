module 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionMigrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun check_is_valid(arg0: &Version) {
        assert!(arg0.version == 1, 13835058278620528642);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public(friend) fun migrate(arg0: &mut Version) {
        let v0 = arg0.version;
        assert!(v0 <= 1, 13835339796547043332);
        if (v0 < 1) {
            let v1 = VersionMigrated{
                from : v0,
                to   : 1,
            };
            0x2::event::emit<VersionMigrated>(v1);
            arg0.version = 1;
        };
    }

    // decompiled from Move bytecode v7
}

