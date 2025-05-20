module 0xf5054c3bc2cfb659844109ac1a434ee290fa1bf76d56ae93500d1e83b41107e7::bunk {
    struct BUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BUNK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BUNK>(arg0, b"Bunk", b"Splash Bunk", b"A new wave just hit the Sui Chain SPLUSH BUNK has landed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRoiMMZEvQGYvBxxBHtSkzAzH4ojjxs3RLWkFKNjicscM")), b"https://suibunkmeme.fun", b"https://x.com/suibunk", b"DISCORD", b"https://t.me/suibunk", 0x1::string::utf8(b"006ceb14956f1d6fd6675a9ee66b172e381960ba8dad907f01829851bc25ad2b2f91b9326a6d8b5662bb645d5f24a1f79172590dc98a1b7e9d064ca7056f06d00cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747760106"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

