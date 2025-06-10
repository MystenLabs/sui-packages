module 0x46064b2c7529ce77d197a7df14d8ea4551ef85954b52ad8e925446d1c67a1d16::btcai {
    struct BTCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BTCAI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BTCAI>(arg0, b"BTCAI", b"AIBTC", b"New project AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXEpZic4GfKbFNcsovNG94n1CszXwnKJ5UmH91FA7ViFn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008b93dea9fdb675990e314da4efb5fa6797321a97b1c360c75887020e9ff36db5becca53f4ee012e440c9e207e8512838c477feb83beb08c5ffa39d717358b30ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749532543"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

