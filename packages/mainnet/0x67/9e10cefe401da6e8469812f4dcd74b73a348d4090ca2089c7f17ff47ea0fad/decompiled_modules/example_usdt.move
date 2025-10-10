module 0x679e10cefe401da6e8469812f4dcd74b73a348d4090ca2089c7f17ff47ea0fad::example_usdt {
    struct EXAMPLE_USDT has drop {
        dummy_field: bool,
    }

    public fun get_token_info() : (vector<u8>, vector<u8>, u8) {
        (b"USDT", b"Example Tether USD", 6)
    }

    fun init(arg0: EXAMPLE_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let EXAMPLE_USDT {  } = arg0;
    }

    // decompiled from Move bytecode v6
}

