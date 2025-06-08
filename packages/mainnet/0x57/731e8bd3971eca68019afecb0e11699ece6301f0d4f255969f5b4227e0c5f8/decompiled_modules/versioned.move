module 0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 2, 0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::errors::version_deprecated());
    }

    public fun emergency_pause(arg0: &mut Versioned, arg1: &0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::admin_cap::AdminCap) {
        arg0.version = 9223372036854775808;
    }

    public fun emergency_restore(arg0: &mut Versioned, arg1: &0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::admin_cap::AdminCap) {
        arg0.version = 2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::admin_cap::AdminCap) {
        assert!(arg0.version < 2, 0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::errors::invalid_version());
        arg0.version = 2;
    }

    // decompiled from Move bytecode v6
}

