module 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::version_deprecated());
    }

    public fun emergency_pause(arg0: &mut Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap) {
        arg0.version = 9223372036854775808;
    }

    public fun emergency_restore(arg0: &mut Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap) {
        arg0.version = 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

