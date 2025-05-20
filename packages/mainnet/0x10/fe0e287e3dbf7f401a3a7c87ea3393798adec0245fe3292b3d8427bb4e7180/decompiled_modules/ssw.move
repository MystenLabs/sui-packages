module 0x10fe0e287e3dbf7f401a3a7c87ea3393798adec0245fe3292b3d8427bb4e7180::ssw {
    struct SSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SSW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SSW>(arg0, b"SSW", b"Sui Splash Waterpark", b"The first decentralized waterpark experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVg12mPWsuVitKnpshSeZRre2Nsg29tyiV6dhAx7yQHpd")), b"WEBSITE", b"https://x.com/SuiNetwork/status/1907094037032473037", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000ad5597ba32c26b81fd12095f346f3833233fd7611c2fb6e471177a5c70451e8085708a04a0f91a6d36369e1c894618b4686e1d64c5346ddbde18ce85fba7e00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747767996"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

