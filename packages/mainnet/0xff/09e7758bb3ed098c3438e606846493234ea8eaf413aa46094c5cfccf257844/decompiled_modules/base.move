module 0xff09e7758bb3ed098c3438e606846493234ea8eaf413aa46094c5cfccf257844::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BASE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BASE>(arg0, b"Base", b"The", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/QmPMgTcM321C735FUC6LPEhhzu7jVZR8cDjDUNLtrx5Sf8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a607c03ed199dc58495979bfae5f7cda8ca5b06dc47c2abce5d7ed2ecf26f1458111a8b234eb7c8f74562391eaea7c9b708019e3cd8001733b193be34c054002f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739292024"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

