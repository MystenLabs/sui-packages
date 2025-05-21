module 0xff2a47c352dfab2ee74718d9b641979caf5e57cd9129b1fd6a5797adeb7af922::wor {
    struct WOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WOR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WOR>(arg0, b"WOR", b"A clockwork orange", b"till nibiru", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXfGtByRdmfJLkWtKBCrigGQ92Bdz5LhKs2MLz6nCWyqW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d6863dc41d0e3c6991243cfbbf1de38bd0267b82de61c527fab0ede6d1174ee97ddf6195914766eac9c60f7d4c54b74f223705f663101e87c85859e0511a870ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747831564"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

