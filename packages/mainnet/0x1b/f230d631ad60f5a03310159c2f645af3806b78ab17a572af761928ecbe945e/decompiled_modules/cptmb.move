module 0x1bf230d631ad60f5a03310159c2f645af3806b78ab17a572af761928ecbe945e::cptmb {
    struct CPTMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPTMB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CPTMB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CPTMB>(arg0, b"CPTMB", b"Captain MemeBeard", b"Captain MemeBeard sail the open sea and finds the treasure, one meme at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVwNW7t3dj6ZwURCvQXaQFbVC3n8QubB9cmLywZqtvV5c")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001dbae8a7d3eacff4d1bd23f5bd96de4694b48a10c22362fc66d3428abb0bc9c865230dedb7aafe08581f91caf1fc90d82f12b85987e9566c9e506c173ad0ec05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759932"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

