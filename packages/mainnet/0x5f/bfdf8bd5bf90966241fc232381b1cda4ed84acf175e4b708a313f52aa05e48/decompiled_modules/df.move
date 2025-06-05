module 0xec320ba9fa2ab4a2adf6e6ec40118e4dc7e776b50d3df18f7ff00c2d00127a2c::df {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        x: u64,
    }

    struct GlobalV2Config has store, key {
        id: 0x2::object::UID,
        y: u64,
    }

    public fun add_global_v2(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalV2Config{
            id : 0x2::object::new(arg1),
            y  : 222,
        };
        0x2::dynamic_object_field::add<u64, GlobalV2Config>(&mut arg0.id, 2, v0);
    }

    public fun get_global_v2(arg0: &mut GlobalConfig) : u64 {
        0x2::dynamic_object_field::borrow<u64, GlobalV2Config>(&arg0.id, 2).y
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id : 0x2::object::new(arg0),
            x  : 111,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public fun init_global(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id : 0x2::object::new(arg0),
            x  : 111,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

