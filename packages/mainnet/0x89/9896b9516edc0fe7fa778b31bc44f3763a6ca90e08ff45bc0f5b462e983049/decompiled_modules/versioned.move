module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VERSIONED has drop {
        dummy_field: bool,
    }

    struct VersionUpgradedEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 1);
    }

    public fun current_version_const() : u64 {
        1
    }

    fun init(arg0: VERSIONED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::admin_cap::SuperAdminCap) {
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
        let v0 = VersionUpgradedEvent{
            old_version : arg0.version,
            new_version : 1,
        };
        0x2::event::emit<VersionUpgradedEvent>(v0);
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

