module 0x1fa6a22c94af3f80430e0468953c4ef98d049f3b1632c2a9e63700d87a23e58f::shlt {
    struct SHLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHLT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHLT>(arg0, b"Shlt", b"Splashlt", b"migration of splashy: buy Splashlt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZLjJ257iYLCU2A8vEXtLNA8T5WwYU499C3r84i95K2T7")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/splashy_CTO", 0x1::string::utf8(b"009530a2621982df1f9aacaf2815ac1c860b3bb5fc6cac6d7e0ac820721befce2223f795f211238ec2bc110dd2d00b76a0f445b39fcca691b4145d8e5a3f32b702d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770424"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

