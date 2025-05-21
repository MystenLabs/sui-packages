module 0xfc7d2b2752459c936c382b9727c5adc25b3113d7f95c7b8d472629452ba884d2::skibo {
    struct SKIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SKIBO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SKIBO>(arg0, b"Skibo", b"Kibo", b"Token Sui from another", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU46y2341L7gbFXwHK8qECmdF8BYWfHTFztgPjojaH6me")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00eed15e3bda0099c50ee945ee17ac190d965585b78f79e7563dd30f4d1590ad0ef88e3e0d0d81996f728861fbea450fb0fd78bf9fc92bf4bbef806af36ef93a04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747837924"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

