module 0x7d5eef5a242f3b80362eef08d5d1a4f0ddda632ac4a6b0ba49068dc3ce2c7c07::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOON>(arg0, b"MOON", b"Moonpig", b"Moonit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf1iYXa6mJbT87yyH1NRn3vDk8rvd7FJyr3whHPoCHefT")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00aeb4670ef303435be426b936881c52c0a7fc9174936ff45d1e45e1d77cf34aace00008f6b6d91cca6e96d27f3f896d91013dec70b9eb6d124415a47d54b7070bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761435"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

