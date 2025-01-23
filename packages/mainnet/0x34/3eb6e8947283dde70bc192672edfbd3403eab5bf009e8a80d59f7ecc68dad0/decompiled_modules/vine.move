module 0x343eb6e8947283dde70bc192672edfbd3403eab5bf009e8a80d59f7ecc68dad0::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<VINE>(arg0, 18077646966564815966, b"Vine Coin", b"Vine", b"Do it for the Vine.", b"https://images.hop.ag/ipfs/QmUsUiknPq9Y8zRhKKTBv7sX4CtcRQCBo6nJZhGwHmosmv", 0x1::string::utf8(b"https://x.com/rus"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

