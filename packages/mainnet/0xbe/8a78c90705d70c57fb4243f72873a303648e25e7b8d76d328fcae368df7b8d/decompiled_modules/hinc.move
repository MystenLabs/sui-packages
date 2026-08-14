module 0xbe8a78c90705d70c57fb4243f72873a303648e25e7b8d76d328fcae368df7b8d::hinc {
    struct Hinc has key {
        id: 0x2::object::UID,
    }

    public fun create_ds_token(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::coin_registry::CoinRegistry, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::MetadataCap<Hinc>, 0x2::coin::TreasuryCap<Hinc>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<Hinc>(arg5, arg4, arg1, arg0, arg3, arg2, arg6);
        (0x2::coin_registry::finalize<Hinc>(v0, arg6), v1)
    }

    // decompiled from Move bytecode v6
}

