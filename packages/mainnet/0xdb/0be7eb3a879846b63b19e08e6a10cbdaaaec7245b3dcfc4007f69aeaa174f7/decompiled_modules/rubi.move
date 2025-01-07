module 0xdb0be7eb3a879846b63b19e08e6a10cbdaaaec7245b3dcfc4007f69aeaa174f7::rubi {
    struct RUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RUBI>(arg0, 13038653789138466182, b"RUBI", b"RUBI", x"5320686520552027732049206e74656c6c6967656e63650a202d74686520656e642e", b"https://images.hop.ag/ipfs/QmUuAGbASSS1qH2HVmpGWjuGj5hw9t9m9mm236Fgy3pVNa", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

