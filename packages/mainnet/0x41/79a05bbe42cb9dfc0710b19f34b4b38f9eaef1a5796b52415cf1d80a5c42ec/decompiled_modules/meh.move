module 0x4179a05bbe42cb9dfc0710b19f34b4b38f9eaef1a5796b52415cf1d80a5c42ec::meh {
    struct MEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<MEH>(arg0, 4854357950968970657, b"SUIMEH", b"MEH", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e", b"https://images.hop.ag/ipfs/QmZxmCHTpm6CWbewbBXueA3xjhuqBZ7k2SqvjgypwHn1Fr", 0x1::string::utf8(b"https://x.com/_suimeh_?t=WOPraVJRdurthkQKY_gxCQ&s=09"), 0x1::string::utf8(b"https://suimeh.xyz/"), 0x1::string::utf8(b"https://t.me/suimeh"), arg1);
    }

    // decompiled from Move bytecode v6
}

