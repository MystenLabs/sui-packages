module 0x1f046ffea4792acc01ce3d4d8627cbc9eaf5bfef146461084643fb9ba0da797d::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JELLY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JELLY>(arg0, b"JELLY", b"Portal", b"Portal to Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNqaa6pKs44nWwDdpHTSxPPCWKz21D2LK5AD7JiN589ua")), b"https://portaltobitcoin.com/", b"https://x.com/portaltobitcoin", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000d324c0b3dbba39dddfab9c822a4d1c7c6b0574e061b8789157de8677741e450b14e145b6387103c08348b0c4502b9a6cd977d0eaa0d6a2846742c0301c2de0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748034164"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

