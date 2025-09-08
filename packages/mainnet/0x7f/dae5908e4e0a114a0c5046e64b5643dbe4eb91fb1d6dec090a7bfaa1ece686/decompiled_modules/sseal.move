module 0x7fdae5908e4e0a114a0c5046e64b5643dbe4eb91fb1d6dec090a7bfaa1ece686::sseal {
    struct SSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SSEAL>(arg0, b"SSeal", b"Sui Seal", b"first seal on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZHovfzo5LwHLAG6ogivABQ5Rb6LvkAPMU2GLXQuLqSkt")), b"WEBSITE", b"https://x.com/SuiNetwork", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ea3da9045dae22a6a4a610236290a610171dda7c5ef559731d0884d7be19c3f1103b001f7b81a4ebd5d2e50edae2cb487d1161dc8b5cdcb3f56f10f2ed491b0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757347392"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSEAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

