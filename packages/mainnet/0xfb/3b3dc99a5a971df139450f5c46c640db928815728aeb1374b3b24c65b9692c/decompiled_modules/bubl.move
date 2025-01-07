module 0xfb3b3dc99a5a971df139450f5c46c640db928815728aeb1374b3b24c65b9692c::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BUBL>(arg0, 5641980911367976197, b"Bublsui", b"Bubl", b"Bubbling on Sui Network.", b"https://images.hop.ag/ipfs/QmQ88iGNvXZNgHFTxz2KvuqJ68Bh59geCCwd7eaP52RFW9", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

