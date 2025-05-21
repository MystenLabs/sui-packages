module 0x824e15ca2e78a5d17439357e01882084d5278b19f03820df1190e774d1221a3::ghip {
    struct GHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<GHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<GHIP>(arg0, b"GHIP", b"GIGA HIPPO", b"The Strongest Hippo on the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbtyAXq3sFa7WYKt4CzrhVYR5PcwCn2nXeHc2gYNvTetm")), b"https://gigahippo.fun/", b"https://x.com/gigahippo_", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cd56b0c77a6cb17666b16fa935a2af29c331af20f4eeb52619d5661f4b3a5fbcec493ca3332d5bd102766f32a7c91f2585b15566c51ec117107c17ddf99a8502d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747846241"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

