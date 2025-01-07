module 0x96ab2ce24aebf749af0f0ea44b6573bb74f62ae0666e63dc692baf0a2e2f41ca::teste {
    struct TESTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TESTE>(arg0, 13866233911907449628, b"TESTE", b"TESTE", b"123", b"https://images.hop.ag/ipfs/QmR32Gdmk8PdLfskQKQv2W7PmUCCY8QoWS9eRDRRbivWWN", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

