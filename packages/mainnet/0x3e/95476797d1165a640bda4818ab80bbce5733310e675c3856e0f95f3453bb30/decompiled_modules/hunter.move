module 0x3e95476797d1165a640bda4818ab80bbce5733310e675c3856e0f95f3453bb30::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<HUNTER>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<HUNTER>(arg0, b"HUNTER", b"Cat", b"Cat hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcshbk8mwNLAuZLwgdc5FNPbcdZVJ9idi1xEWxcGDxXJj")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e484663629a3e4fd36a3545a913e97a68c5c98f5905dbbea39a06e8b395bbcdf97a6184b4435897c8d672cb8238c0b0258e00d30e4a1419ddb1dc1319b4e450df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743420773"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

