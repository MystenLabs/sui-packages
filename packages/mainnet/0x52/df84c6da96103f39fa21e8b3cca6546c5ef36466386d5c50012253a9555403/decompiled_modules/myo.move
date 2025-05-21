module 0x52df84c6da96103f39fa21e8b3cca6546c5ef36466386d5c50012253a9555403::myo {
    struct MYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MYO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MYO>(arg0, b"MYO", b"monkey", b"the monkey wants banana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmecV3RbEXxrMsELNDvVnhPRim9D3NPdoj7FtjxUdu3Sf3")), b"WEBSITE", b"https://x.com/Torito00Trueno", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a45f5a2b1c0cc50217d8cd3e9253a90908aa4258ec4fe0639462bd90e53c82fef52477f03b18e198a7693ce69db2e674e39a58067d08dc46b80ee530165ae90ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747812495"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

