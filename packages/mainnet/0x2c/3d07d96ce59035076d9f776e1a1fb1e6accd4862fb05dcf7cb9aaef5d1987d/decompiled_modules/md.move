module 0x2c3d07d96ce59035076d9f776e1a1fb1e6accd4862fb05dcf7cb9aaef5d1987d::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MD>(arg0, b"MD", b"Maodi", b"Its a harmless cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX9ahDe1LPU56JKc58KQUFoTffTEzAm6dwoWLfZmrSKuC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004cbfdccb1c72ab6976bb17247c269f650c8d856155b3c588a9b1718074ce14e54d7ed9fe64873ddc206f229334a6abc73ac53d20ce451f548333942412eb0505d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747852621"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

