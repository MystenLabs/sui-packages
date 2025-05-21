module 0x777292f2fc716af1e9f77b8ad25a7af054ce42ed44abdd41909312d1a46c44b3::sscan {
    struct SSCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SSCAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SSCAN>(arg0, b"SSCAN", b"Splash Scan", b"Track tokens, run insights, and buy instantly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmbx2jiLANFx2dyZbHgmSPueJ4XfbvWGPyZYsjeGQUySLC")), b"WEBSITE", b"https://x.com/SplashScan", b"DISCORD", b"https://t.me/SplashScan", 0x1::string::utf8(b"005497a6cc8e3dd606226a0009c8ae86c2c0bb9e7486444493fb9c862e401b9c22d3147f1e97dc20ca3f42212688984be932087706c31a05521fc18004d0a7d40ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747852095"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

