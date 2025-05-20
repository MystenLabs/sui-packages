module 0x76a47e343e5ec82cbfc32d015c6fb16eeb57e1f5a030c99d04483cff7a21c987::suiseum {
    struct SUISEUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUISEUM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUISEUM>(arg0, b"SUISEUM", b"Suiseum", b"An impressive and exotic way to appreciate SUI art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeAuAUr9Dv8eJjVxVNdQBUj6nc5MHhSFg461odRLLpyxR")), b"https://www.thesuiseum.fun/", b"https://x.com/SuiSeum", b"DISCORD", b"https://t.me/TheSuiseum", 0x1::string::utf8(b"0075e08761043f8470f9c11149f3e0b045ce062fbeb4cc4c9cf6353e20117f233ebf96ca84901c5df408c315b18a50849812e65884685cca723d8cb4c7329a1506d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747772546"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

