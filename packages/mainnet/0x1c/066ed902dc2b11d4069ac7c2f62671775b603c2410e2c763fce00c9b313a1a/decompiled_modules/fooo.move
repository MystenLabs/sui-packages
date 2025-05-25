module 0x1c066ed902dc2b11d4069ac7c2f62671775b603c2410e2c763fce00c9b313a1a::fooo {
    struct FOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FOOO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FOOO>(arg0, b"FOOO", b"FOGO", b"Keep me and you will see the wonder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRR9JYyjpMB5yDGE4Znfs4xutwxdDU4YcYwCSq9CGxZcq")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009eb8d26e3f3bf92a7ed3177612fd5aeebda050cf454c725990f7181785eb1133ed9ab604f99cbf2e58ae4a3b0a02b0629b512db0bcd99d1aa91616e9fe415306d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748203992"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

