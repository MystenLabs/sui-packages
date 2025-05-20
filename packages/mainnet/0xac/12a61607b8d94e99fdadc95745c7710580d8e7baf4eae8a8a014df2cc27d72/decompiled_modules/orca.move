module 0xac12a61607b8d94e99fdadc95745c7710580d8e7baf4eae8a8a014df2cc27d72::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ORCA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ORCA>(arg0, b"Orca", b"Splash Orca", b"a large toothed whale with distinctive black and white markings and a prominent dorsal fin. It lives in groups that cooperatively hunt fish, seals, and penguins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZYkS6tzrGAb1tWxuihNYYj6FN11WKJMn5w3VUWeg9YGn")), b"https://orcasui.site/", b"https://x.com/orca_onsui", b"DISCORD", b"https://t.me/splashorca", 0x1::string::utf8(b"006e268c4d83eaab15854e16d0762cd81f996242c79cb3758561a85c061caf45bacc5835bef5165581863e71f196140c6c3caa69c1d301033f92681facf534f00ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759517"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

