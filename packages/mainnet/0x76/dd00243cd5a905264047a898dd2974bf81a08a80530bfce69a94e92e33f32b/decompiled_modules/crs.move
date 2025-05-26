module 0x76dd00243cd5a905264047a898dd2974bf81a08a80530bfce69a94e92e33f32b::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CRS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CRS>(arg0, b"CRS", b"CROCOSUI", b"imaginary crocodile around the suien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcwJfjfUMnLbKzKUFVpoe5g8oeTJGE7yye2vXYydfWCeR")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d644384177e3af8719c2b60b3c9fcdc24fe747b0ee17c955d7bb6a7835cccd2ae14c53fd7156282845a73b1d0883f23b28940fa1112caa199baa3fbf49287b07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748219681"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

