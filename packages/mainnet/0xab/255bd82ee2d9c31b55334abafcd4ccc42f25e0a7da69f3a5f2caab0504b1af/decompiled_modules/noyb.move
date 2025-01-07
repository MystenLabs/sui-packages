module 0xab255bd82ee2d9c31b55334abafcd4ccc42f25e0a7da69f3a5f2caab0504b1af::noyb {
    struct NOYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOYB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NOYB>(arg0, 15328668194447417680, b"None of Your Business", b"NOYB", b"None of Your Business", b"https://images.hop.ag/ipfs/QmXRAbjDvn9tad1M9qbJjHnAVGs3FEAczqqEAVzgq6YYge", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

