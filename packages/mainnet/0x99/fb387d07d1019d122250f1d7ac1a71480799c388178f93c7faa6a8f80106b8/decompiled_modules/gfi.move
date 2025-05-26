module 0x99fb387d07d1019d122250f1d7ac1a71480799c388178f93c7faa6a8f80106b8::gfi {
    struct GFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<GFI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<GFI>(arg0, b"GFI", b"GIFI", b"Focused on donations, micro-funding, or social good.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSTn1j1BLspUXq4TQ5xdcF9mTLP82z2ZLc88RTYynuF5J")), b"https://gifi.com/", b"https://x.com/GIFI", b"https://discord.com/channels/1140905663111909446/1140987158560260146", b"t.me/gifi", 0x1::string::utf8(b"00755d66cad5855390c15f5bcc30cac39ae6cf588cf84397ba9d56551e284cbb23ca533f438763fcf5d172d72f11061bc72ca00c65fe8d6fe61ad5755d9a67fc03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748259699"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

