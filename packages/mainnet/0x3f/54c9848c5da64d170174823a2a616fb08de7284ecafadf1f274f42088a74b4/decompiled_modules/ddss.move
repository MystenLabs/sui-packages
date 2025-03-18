module 0x3f54c9848c5da64d170174823a2a616fb08de7284ecafadf1f274f42088a74b4::ddss {
    struct DDSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DDSS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DDSS>(arg0, b"DDSS", b"DOGSS", b"BIG SUI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaZmAUi14TPBo3MUAeWp9EkLSCYAeqYpZiCpPYRAQGn41")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00989dc4b33da86a3e6c326ab4d04c0d91a0d68d13989a683107dac20f93fd0fe54195489451bcc5acde930f6aa19af0d95c6412e851db2d7110515380db3c1f00f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631742296571"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

