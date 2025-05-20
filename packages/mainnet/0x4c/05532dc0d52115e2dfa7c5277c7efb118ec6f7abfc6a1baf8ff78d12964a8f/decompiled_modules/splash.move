module 0x4c05532dc0d52115e2dfa7c5277c7efb118ec6f7abfc6a1baf8ff78d12964a8f::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASH>(arg0, b"SPLASH", b"Splash Official", x"5468652066697273742066616972206c61756e636820706c6174666f726d206f6e2053756920f09f92a7496e7374616e74206c61756e636865732e20436f6d6d756e6974792d66697273742e204275696c6465722d67726164652e2020506f77657265642062792024484950504f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmexygpth6wwmVRxTk6iLmu1YjrqZBHeAymFQb24jHHmty")), b"https://splash.xyz/", b"https://x.com/splash_xyz", b"DISCORD", b"https://t.me/splash_support", 0x1::string::utf8(b"0096509e44503c0cfd9180173bcffcdd228692875953257966dcabe6f266d745c18a9e592cd5ac66671d52ded3881fddb1ea8daf5a99e897456f6713db31782e0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756241"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

