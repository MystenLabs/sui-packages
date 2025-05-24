module 0xd1138889f936249a30243c81610f29a988f68a6fba92f00fd12e8662e2b331c7::id {
    struct ID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ID>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ID>(arg0, b"ID", b"Imaginary Doodle", b"You can imagine this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYaWxYPEvWaY1LGcxMqne8MQR6K4C5LLemmLSMJ9vt2xZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0020d6e96406dd3aa93811ffd830b335233772b80c0307acdb6165e97bf586fb3ec9db987ec437e4994500c6dc299773d7514a75298513566a1ec2e0ba4fbaa909d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748095291"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

