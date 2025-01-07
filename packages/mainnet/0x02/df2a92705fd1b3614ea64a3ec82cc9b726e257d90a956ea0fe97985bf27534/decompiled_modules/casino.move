module 0x2df2a92705fd1b3614ea64a3ec82cc9b726e257d90a956ea0fe97985bf27534::casino {
    struct CASINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASINO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CASINO>(arg0, 12254936750693387642, b"ebanyy-rot-etogo-kazino", b"CASINO", b"end of the road in trying to fuck the casino", b"https://images.hop.ag/ipfs/QmNbR8EqVEbVe8QNJjgRhq8Tccy2W8KYyx1Gndfw888c9U", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

