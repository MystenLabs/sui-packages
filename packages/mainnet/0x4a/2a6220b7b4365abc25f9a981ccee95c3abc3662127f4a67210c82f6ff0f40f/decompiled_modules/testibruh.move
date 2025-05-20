module 0x4a2a6220b7b4365abc25f9a981ccee95c3abc3662127f4a67210c82f6ff0f40f::testibruh {
    struct TESTIBRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTIBRUH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TESTIBRUH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TESTIBRUH>(arg0, b"Testibruh", b"Testi", b"testibruh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR6Qnzo7GJEJ87Jffih94xE2mWq8NNn6PrptShjdsJb9B")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c2165e5c66f747638f27c1629265bd250f87c01e246243e0b0db7944070c2633255cd0aa5d64cb3fb0e8366ac165b435536b88540c6f31c4ee967d948fc36301d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762243"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

