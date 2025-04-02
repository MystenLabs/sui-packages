module 0x36258717ec8ffa61d910cc1977d56c94a885400b32d904764eb1c47016a4e267::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SSS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SSS>(arg0, b"SSS", b"TEST2", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeddjFzxP5Tg4mgPh9JGFWVaoJauR3AfFkb57K77vfUwN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0057776438654214dc888398e6a1080e5f910548cd87e96cec5e95ab0284fa855bdfd804f5c32038ac228c9801670d68a320abe3cbe10ae1bb46172cbeb84812097b08d9209dea8e2521b5e3f461f27ccd9b2ac43433f9f61559a0ee890e4e72851743601094"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

