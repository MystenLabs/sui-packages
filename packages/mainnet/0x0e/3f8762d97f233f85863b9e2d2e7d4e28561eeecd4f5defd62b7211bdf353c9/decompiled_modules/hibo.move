module 0xe3f8762d97f233f85863b9e2d2e7d4e28561eeecd4f5defd62b7211bdf353c9::hibo {
    struct HIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIBO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIBO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIBO>(arg0, b"HIBO", b"HIBBO", b"MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcjuzJU8wamoSNtkjVrs1ekYUG1UqsWTCtuZdcHmHvKZm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009781f1c1af15ecef3194593860b1b1d810c2f1a12d037b012eae8af465f07e8527014044770e58733c7a966aafacc6ee4a24b06e7080b6c54b97b1e341119a05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748122610"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

