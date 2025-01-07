module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        max_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        version: u64,
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        (arg0.min_tick, arg0.max_tick)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            min_tick : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::neg_from(443636),
            max_tick : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::from(443636),
            version  : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun verify_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::version_mismatch());
    }

    // decompiled from Move bytecode v6
}

