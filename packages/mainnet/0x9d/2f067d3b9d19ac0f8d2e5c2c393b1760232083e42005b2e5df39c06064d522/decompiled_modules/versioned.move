module 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::version_deprecated());
    }

    public fun emergency_pause(arg0: &mut Versioned, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::admin_cap::AdminCap) {
        arg0.version = 9223372036854775808;
    }

    public fun emergency_restore(arg0: &mut Versioned, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::admin_cap::AdminCap) {
        arg0.version = 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

