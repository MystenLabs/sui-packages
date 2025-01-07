module 0xaaee720135f0c2d4e868d381401296394326131ca5c04e96bcb777c8608b569::ivan {
    struct IVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<IVAN>(arg0, 13138894531069282538, b"IVAN", b"IVAN", b"IVAN IZ GRUZII", b"https://images.hop.ag/ipfs/QmV9zxMB7pYBLmbMTh3p5EcCUvWHU6g4B93w7Us56h8B7U", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

