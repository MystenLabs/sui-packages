module 0xec320ba9fa2ab4a2adf6e6ec40118e4dc7e776b50d3df18f7ff00c2d00127a2c::df {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        x: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id : 0x2::object::new(arg0),
            x  : 111,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

