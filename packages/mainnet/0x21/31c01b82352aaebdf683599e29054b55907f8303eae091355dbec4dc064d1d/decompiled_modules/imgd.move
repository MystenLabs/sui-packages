module 0x2131c01b82352aaebdf683599e29054b55907f8303eae091355dbec4dc064d1d::imgd {
    struct IMGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMGD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<IMGD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<IMGD>(arg0, b"IMGD", b"Imaginary Doodle", b"How old are you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYaWxYPEvWaY1LGcxMqne8MQR6K4C5LLemmLSMJ9vt2xZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0056762e9d49072fed97032819ad61849f6b2cfb0acfa4fdc6a7eca578d900a203073e29e15b87ea215ea6df8236edb7945dc70f39befbd2852501a59e726c1e06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748095564"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

