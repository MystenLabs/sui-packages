module 0x5428a10e978b347235033fa1a503cb1adb15bf1b86e44578fc360fca5595de13::brde {
    struct BRDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<BRDE>(arg0, b"BRDE", b"Beardie OF SUI", b"Beardie is the rising meme coin on Sui, blending community vibes with a playful edge that makes it more than just a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeozutZChDXYapBLKRiw1z2A8niu6p3hWjPaXDZFPLbkn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005b46e46af68b88033fa4494996513125e668041735233364afa0d9ef218234495722fe3c41c076c2cc33773932773a80bbba898a06eb98bb2e5bae4f2e344404d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757601805"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRDE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

