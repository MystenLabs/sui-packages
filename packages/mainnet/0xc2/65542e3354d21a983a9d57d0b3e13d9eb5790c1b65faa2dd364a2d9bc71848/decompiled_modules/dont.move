module 0xc265542e3354d21a983a9d57d0b3e13d9eb5790c1b65faa2dd364a2d9bc71848::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DONT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DONT>(arg0, b"DONT", b"dontbuy", b"DONT BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP1CJdUBTv8G1barkXK8oNobA23ikuqzrryGLUoxqLe4H")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005dfb0796951ab72886c3a8d9b4e90912f264e498f51e3c7b47fad1462b9bcce9bb2e58d1bbc0a36256284c9348cf0349519ce78a0e1d653f6e55dfb898f76b0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757858"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

