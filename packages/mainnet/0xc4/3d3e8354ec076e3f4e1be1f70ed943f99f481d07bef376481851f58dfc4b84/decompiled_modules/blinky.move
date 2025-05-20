module 0xc43d3e8354ec076e3f4e1be1f70ed943f99f481d07bef376481851f58dfc4b84::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BLINKY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BLINKY>(arg0, b"BLINKY", b"Sui Blinky", b"$BLINKY, first SUI fish full of splashes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbHisNCHLwXMwAtHp9SRcV59WKVL4kxMTJSNT4hVDH6Yi")), b"WEBSITE", b"https://x.com/SuiBlinky_", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009476b94fc67b2b466716740d047e623c3b658d787faf4f9257357c21b0c9f1789b1766534c6b470487397c96637730c03b106e2e6342a285074fd995fb863a0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757092"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

