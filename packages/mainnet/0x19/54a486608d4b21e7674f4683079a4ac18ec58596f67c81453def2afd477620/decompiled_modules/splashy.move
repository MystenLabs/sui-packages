module 0x1954a486608d4b21e7674f4683079a4ac18ec58596f67c81453def2afd477620::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHY>(arg0, b"Splashy", b"SplashyonSUI", x"53706c61736879207468652067686f737420726f616d732061726f756e642074686520537569206e6574776f726b2e20f09f91bb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSmQrimjM9gVGE7KZU7ygWG7ugqTrG7sabYoVED1tQe51")), b"WEBSITE", b"https://x.com/SplashyOnSui", b"DISCORD", b"https://t.me/splashyonsui", 0x1::string::utf8(b"0092215e18d359aa70ca9598b86234b2b9b8880aeff33dec7054cb19bb614b2d9e07acbbc4ecc71be50c4249ff7b7162cc98f4179ff322dcf64db2e15f8a9a8e0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757573"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

