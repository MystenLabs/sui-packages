module 0xece184f521427ec201a0cd49090ee6140a8f2a9087badf4a80f915a67884d2e2::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SDOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SDOG>(arg0, b"SDOG", b"SPLASH DOG", b"splash dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX1h4A92vbgz3WVXd5jTxdNxQ5H6LFduMmGVWbvVahbhz")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0072bdd6ce95e9fb9ad3fdf7430b96449cc0ed4873f86daeadf3ced7001f6a9b2cb12b08a2757a1197a481b371e76fc0502fde658a9a297d8492682ff684e2d100d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757688"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

