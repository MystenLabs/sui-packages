module 0xda94ecca6d7ddf4c838d56256e662f8a31c70bfaab594868e8d327ed9113d646::repai {
    struct REPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<REPAI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<REPAI>(arg0, b"REPAI", b"Giverep AI", b"For entertainment purposes only and not for commercial purposes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ9djYEW43PPfBRK1JotEvKvxDW5QTLFrp6NwhP6ZHFqR")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002660ba0796ebc76a69f7165cd5d20f01dc3bf7dd8980eb5cb4a49c345f046513adf00dd0a5eb54e16f6d083244a286d0406f94e3f788db0900d1860ca2b74d0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748064642"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

