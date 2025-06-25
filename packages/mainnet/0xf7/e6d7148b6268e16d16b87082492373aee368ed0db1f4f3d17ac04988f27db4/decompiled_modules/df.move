module 0x220a227dfec7e67c65f628650ad1390699af279f01b6e43b088a12523ff8e6b4::df {
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

    public fun set_global(arg0: &mut GlobalConfig) : u64 {
        arg0.x = arg0.x + 100000;
        arg0.x
    }

    // decompiled from Move bytecode v6
}

