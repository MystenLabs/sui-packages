module 0x98e0ba60d02c6797a44ad0b33e8299a2cdb313062106cffeeea2b37587948498::t224 {
    struct T224 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T224, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<T224>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<T224>(arg0, b"T224", b"omega", b"CEO OUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdUL2UHMU9Q5mT9LiFDp5LCPi7GMzcQCUeDgYY88QmCoj")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a0a445b2dbcf4830abdfd5bafba9069ac5e1a1eafd4acc54d0826783b989d3f094127192946885328e4ebf269bb4dc57b861dac91425d18fa05e235dc78c0107d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748074470"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

