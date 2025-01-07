module 0x598d1f9b4bb09c1421be9748aa33a9061b03abc3bc16a97d530d1df102fbf6a3::would {
    struct WOULD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOULD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WOULD>(arg0, 17228676713310846444, b"WOULD", b"WOULD", x"456c6f6e206c6f7665732074686973206d656d65730a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f313836303530353139343138333734353636372f70686f746f2f31", b"https://images.hop.ag/ipfs/QmTRK54JZdp1w7yY43993DmqZNFfD9rGpYD4LSqbixKNf2", 0x1::string::utf8(b"https://x.com/elonmusk/status/1860505194183745667/photo/1"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

