module 0xce694e20617c0f8f4fc82786c7c0e560e510f3b3289ee04bf844b3398e01191d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0xce694e20617c0f8f4fc82786c7c0e560e510f3b3289ee04bf844b3398e01191d::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xce694e20617c0f8f4fc82786c7c0e560e510f3b3289ee04bf844b3398e01191d::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0xce694e20617c0f8f4fc82786c7c0e560e510f3b3289ee04bf844b3398e01191d::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

