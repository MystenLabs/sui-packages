module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned {
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
        assert!(arg0.version <= 2, 1);
    }

    public fun current_version_const() : u64 {
        2
    }

    fun init(arg0: VERSIONED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg1),
            version : 2,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap) {
        assert!(arg0.version < 2, 2);
        arg0.version = 2;
        let v0 = VersionUpgradedEvent{
            old_version : arg0.version,
            new_version : 2,
        };
        0x2::event::emit<VersionUpgradedEvent>(v0);
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

