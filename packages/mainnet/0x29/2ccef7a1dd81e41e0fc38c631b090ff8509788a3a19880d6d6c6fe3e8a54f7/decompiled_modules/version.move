module 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 9223372204358500353);
    }

    public(friend) fun create_version(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::AdminCap) {
        assert!(arg0.value == 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::current_version::current_version() - 1, 9223372165703794689);
        arg0.value = 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

