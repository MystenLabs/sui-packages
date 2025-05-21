module 0xa4e30d8d495be9bbe69f179fc24a2c2b42a8d1f87ff876f3a18164998d53c010::golduck {
    struct GOLDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<GOLDUCK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<GOLDUCK>(arg0, b"Golduck", b"Splash Golduck", b"The Most Dangerous Duck On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmesWKPWpmm8YgRRm5sWyEJKv224aNhapC438hKaKzYkVN")), b"https://golduck.site/", b"https://x.com/golduck_sui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a5a8c8b5cdb6428c95d1eb0ff7027c3655d8e5a1df715f44b1aec3bda03049259eb89d2c94b12d1488fc7eb2144fd10e300b3e00003c9520504543673d0c2901d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839068"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

