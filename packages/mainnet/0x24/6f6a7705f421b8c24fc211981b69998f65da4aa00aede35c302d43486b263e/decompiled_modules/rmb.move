module 0x246f6a7705f421b8c24fc211981b69998f65da4aa00aede35c302d43486b263e::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RMB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RMB>(arg0, b"RMB", b"Rambo", b"If This Is from a Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRvPd2uzUrH6WzVjdeeA9tKEmGW9G3jgpTEnfLMghw5cP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ac16713eb12245512bf1a3545213ac12975e95151cb9203a42a6d26b4c4f3c12a4f8eac1318cb57ac813ddc4bec17b879b8a6677ada1d71a2de0439029f5b902d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748156818"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

