module 0xdcff3012983d83c85718b0abab547c34954bc13931dd483e594349e76b36661::splashmoon {
    struct SPLASHMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHMOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHMOON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHMOON>(arg0, b"SPLASHMOON", b"Splash moon", b"New splashmoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfNKrQvderq5qNp5gLgR8yy1DCUeerLCeTzAvqxnDLCbE")), b"https://warpcast.com/alphines.eth", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007e656285c8092425daf64d7dacd3dac0e6138417e35ed2047a7ef58b318fcdacf010fe8c979d2401fa25acd6ee62b8e420c039d7e16a936093b7720211ee6c0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762650"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

