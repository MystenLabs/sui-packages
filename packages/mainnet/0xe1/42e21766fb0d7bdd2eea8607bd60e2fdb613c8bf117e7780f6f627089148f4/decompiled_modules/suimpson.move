module 0xe142e21766fb0d7bdd2eea8607bd60e2fdb613c8bf117e7780f6f627089148f4::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIMPSON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIMPSON>(arg0, b"SUIMPSON", b"Suimpson", b"$SUIMPSON meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVyYWaYDTruEpgxKc7RsGSADppfSLE6hFzBSEYv2KF63U")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ffd39817b639840fb98812f375ee74e2fdf23abee158e86ed9b251c926cf8532b61c3920e6566c845bb2fddf0019cabee97e1d9ad8ea12dab1d886c38ad54304d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747782920"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

