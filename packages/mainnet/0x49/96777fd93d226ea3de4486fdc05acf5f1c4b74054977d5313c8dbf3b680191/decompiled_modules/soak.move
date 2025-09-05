module 0x4996777fd93d226ea3de4486fdc05acf5f1c4b74054977d5313c8dbf3b680191::soak {
    struct SOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SOAK>(arg0, b"SOAK", b"SOAK on SUI", b"Came here to soak!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcmmRgio3PUFEyaZwgyJvvAgjdfrhwXGdL6CpDqF4QXXm")), b"WEBSITE", b"https://x.com/soakdotsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00673a470146c831cd73c0a2e6e7cd2b58bf0eb6c10b4dd31553da8183c94407603f2fa5caf002b14b15b642e96b58e693b36575a22dcbee8961a4cc3dd272e90ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757084052"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

