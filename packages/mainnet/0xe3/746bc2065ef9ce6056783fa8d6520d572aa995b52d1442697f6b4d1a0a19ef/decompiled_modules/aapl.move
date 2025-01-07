module 0xe3746bc2065ef9ce6056783fa8d6520d572aa995b52d1442697f6b4d1a0a19ef::aapl {
    struct AAPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAPL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AAPL>(arg0, 17034128608502241158, b"Apple", b" AAPL", b"Apple coin", b"https://images.hop.ag/ipfs/QmYj9tY8EypJTB9vW1HDDxgbu7ghDLp6n3dsuRhAj5XVJ9", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

