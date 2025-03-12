module 0xd323c1193c02b615d3e2bf545a0bf877548955e59647551bf3454ddd7f83ff5d::ccccc {
    struct CCCCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCCC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<CCCCC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<CCCCC>(arg0, b"CCCCC", b"Cat", b"The best cat ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcshbk8mwNLAuZLwgdc5FNPbcdZVJ9idi1xEWxcGDxXJj")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004f1dc19ca7d6f09a218aa0542118f4f8c7e03aa0af03e767657be0597c066d0e31e1e5a256ddbb252e1ebf6b3da2354a80debf81495dc736ac47be075dad040bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631741795368"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

