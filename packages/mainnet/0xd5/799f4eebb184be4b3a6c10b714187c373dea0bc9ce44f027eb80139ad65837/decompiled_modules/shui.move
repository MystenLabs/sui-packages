module 0xd5799f4eebb184be4b3a6c10b714187c373dea0bc9ce44f027eb80139ad65837::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHUI>(arg0, b"SHUI", b"Shui on Sui", b"shui on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSa3XiKgU6fWeuVm95qxi8Sddu5vHcRtbk6GiTC7NKbFJ")), b"https://app.splash.xyz", b"https://x.com/Shuithesui", b"DISCORD", b"https://t.me/ShuiOnSui", 0x1::string::utf8(b"0059bcae01533225e4cbf25c41f0d79b85bd537345aa7d15e667771d08ae9b0aa6daeb3803f8a7f17d506fb7cac9b20ba06f5c0961a2dfb88890ed10edcf15e00ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759239"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

