module 0xc73bc342a0b8e968a8c7c6dbd19fde62ae656a99632a9ab501263af413dc1fba::prs {
    struct PRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PRS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PRS>(arg0, b"PRS", b"PRINTSUI", b"the future print on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRZm3od9vBHYxRc4QLxshrBCmqUY7XamP3JPHtXEAmWPe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c64294bb9e58f34d58979f998918d0cc9a83612ae7d5fb450796e141bf4d2ccedfa7501dcd6d33e7025d7a0a6955136015d4fccea9e70ee865896068b487c90fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748219004"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

