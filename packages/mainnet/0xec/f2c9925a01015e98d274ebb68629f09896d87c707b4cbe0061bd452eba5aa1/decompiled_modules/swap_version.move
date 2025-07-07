module 0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap_version {
    struct SwapVersion has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapVersion{
            id      : 0x2::object::new(arg0),
            version : 4,
        };
        0x2::transfer::share_object<SwapVersion>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut SwapVersion, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &SwapVersion) {
        assert!(4 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

