module 0x564ac5d9b7a33adb53c04947d5227a8bb6686860563c14e5168e0ca6bb4f2eb6::mohip {
    struct MOHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<MOHIP>(arg0, b"MOHIP", b"Mind Of Hippo", x"546865205468696e6b696e672046616365206f662074686520537569204e6574776f726b2e0a576527726520676f696e67206265796f6e642063757465206d656d65732e2057652776652063686f73656e20696e74656c6c6967656e63652c2073747261746567792c20616e64206d696e696d616c69737420706f7765722e20244d4f4849502069736e2774206a757374206120746f6b656e3b20697427732074686520636f6c6c656374697665206d696e64206f662074686520636f6d6d756e69747920616e642061206c6f6e672d7465726d20766973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009492a589db9a226e3d4a5af98eb4c328c398221cc6e0096e9b27abe849d7200b6d4390027ff3c2e9f4babc4e98530b57c7cf7bcaec83e6c929be0b0d47d1f700d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749677494"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOHIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

