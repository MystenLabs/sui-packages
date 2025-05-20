module 0xd3bc5da6d02facb2b9262ed4e3b42fd621b8234cea3e92dfd2101128c7a19d69::splashmoon {
    struct SPLASHMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHMOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHMOON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHMOON>(arg0, b"SPLASHMOON", b"Splash moon", b"Splash the new moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfNKrQvderq5qNp5gLgR8yy1DCUeerLCeTzAvqxnDLCbE")), b"https://warpcast.com/alphines.eth", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00770a598dd6f42fe518a9424c984bc988602f7ccb648dd1414b4dd03373a374e603c7c9a9492628edc9dc361375691ba1a8b059df002d62ad9270bf6addf2d607d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762579"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

