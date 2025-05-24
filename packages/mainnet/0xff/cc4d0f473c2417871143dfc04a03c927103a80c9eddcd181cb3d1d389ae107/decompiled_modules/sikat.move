module 0xffcc4d0f473c2417871143dfc04a03c927103a80c9eddcd181cb3d1d389ae107::sikat {
    struct SIKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIKAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SIKAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SIKAT>(arg0, b"Sikat", b"Sikat Cuci", b"Sikat buat nyuci", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmV6euzP5GtC9pYrvZ3y6aUdHTbPWaxWQrtNZTKV6JkT9M")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006519bff3b60de6a44e8a2a77d899ad8d0c1d653d7c6fc444ea2e8cb432499925e29f7bc45eb0998f176be13d502cd2daac21fd1c06dd61e95de414051e996805d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748094288"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

