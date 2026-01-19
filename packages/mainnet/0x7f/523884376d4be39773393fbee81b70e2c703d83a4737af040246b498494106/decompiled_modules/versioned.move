module 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionedInitEvent has copy, drop {
        versioned_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionUpgradedEvent has copy, drop {
        versioned_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834509350961155);
    }

    public fun current_version() : u64 {
        1
    }

    public fun emergency_pause_version() : u64 {
        18446744073709551615
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        let v1 = VersionedInitEvent{
            versioned_id : 0x2::object::id<Versioned>(&v0),
            version      : 1,
        };
        0x2::event::emit<VersionedInitEvent>(v1);
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834573775601669);
        arg0.version = 1;
        let v0 = VersionUpgradedEvent{
            versioned_id : 0x2::object::id<Versioned>(arg0),
            old_version  : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<VersionUpgradedEvent>(v0);
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

