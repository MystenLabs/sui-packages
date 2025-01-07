module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        max_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        version: u64,
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32) {
        (arg0.min_tick, arg0.max_tick)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            min_tick : 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::neg_from(443636),
            max_tick : 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::from(443636),
            version  : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun verify_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::version_mismatch());
    }

    // decompiled from Move bytecode v6
}

