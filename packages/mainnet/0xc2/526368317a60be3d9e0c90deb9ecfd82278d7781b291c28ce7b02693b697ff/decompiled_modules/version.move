module 0xc2526368317a60be3d9e0c90deb9ecfd82278d7781b291c28ce7b02693b697ff::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun assert_current(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    public fun current(arg0: &Version) : u64 {
        arg0.version
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VERSION>(arg0, arg1);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    // decompiled from Move bytecode v7
}

