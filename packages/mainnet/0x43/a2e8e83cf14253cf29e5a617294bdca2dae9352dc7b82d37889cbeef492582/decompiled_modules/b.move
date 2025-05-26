module 0x43a2e8e83cf14253cf29e5a617294bdca2dae9352dc7b82d37889cbeef492582::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<B>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<B>(arg0, b"B", b"cheshir sui", b"gorter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXE33UpGRabF4oAhcimWmnWFFS12R8aNJuAQAAwyxhkju")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f0f4a172e4fb0d022206b30f970d03431ab4cdea37cce99c0df57a351a53075544ebbc4a74bbc3b9da5978ad38df9e33e6cbc49ebf02c24b19f03349e059130bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748268018"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

