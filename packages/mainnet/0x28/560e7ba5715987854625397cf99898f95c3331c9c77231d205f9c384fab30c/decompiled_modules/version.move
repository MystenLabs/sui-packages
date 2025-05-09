module 0x28560e7ba5715987854625397cf99898f95c3331c9c77231d205f9c384fab30c::version {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 405);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0
    }

    public(friend) fun upgrade_version(arg0: &mut Version) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

