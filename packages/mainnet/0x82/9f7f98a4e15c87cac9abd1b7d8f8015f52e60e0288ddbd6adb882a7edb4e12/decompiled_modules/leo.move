module 0x829f7f98a4e15c87cac9abd1b7d8f8015f52e60e0288ddbd6adb882a7edb4e12::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LEO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LEO>(arg0, b"LEO", b"Leomord", x"53756767657374656420436f696e204e616d653a0af09f928020244c454f20e2809320e2809c54686520636f696e207468617420726964657320746865206d61726b6574206c696b65204c656f6d6f72642072696465732068697320756e64656164207374616c6c696f6e21e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWGxKDEjPfJFUEjWAa7JCU1zLEneCUXpFEahhwcAjdp9F")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00083a4cdbf58a034179c35b02bb5f5020bfbfa848b1116c80aa7271d5427fab11dfeb0a2880ccf86d80bc5217fa2bbed207629f3910c53680f53e10593ca55b08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748084962"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

