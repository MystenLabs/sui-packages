module 0x470131c0c22ff3d27115eb09473fc1d68b628325f9814c99e6a0094ce532c36b::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIMPSON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIMPSON>(arg0, b"SUIMPSON", b"Suimpson", b"Suimpson meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVyYWaYDTruEpgxKc7RsGSADppfSLE6hFzBSEYv2KF63U")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006f3f8c13367f9d2b64c8570a9293f15d52a82b4570b94cdd2f89be8b7bad6d05024359647b0cb8b220d86c059bcb009e9c72007ee0b73417436e22b4d2885c02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747780645"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

