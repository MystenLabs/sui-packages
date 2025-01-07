module 0x6daeffd5c825139a67fceb4ac7bc76692b6051bc3cd0dd42ca26421d22ad584c::meh {
    struct MEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<MEH>(arg0, 15139079468815257810, b"SuiMeh", b"Meh", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e", b"https://images.hop.ag/ipfs/QmetukF527tCCbAyTLddQ9Bs6uVrexrprJ74L31rzbpa1L", 0x1::string::utf8(b"https://x.com/_suimeh_"), 0x1::string::utf8(b"https://suimeh.xyz/"), 0x1::string::utf8(b"https://t.me/suimeh"), arg1);
    }

    // decompiled from Move bytecode v6
}

