module 0x36723411c6332fdb64b0ee4712aa3105fd1854542a59fcf70125ebfac91cce8f::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<HUNTER>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<HUNTER>(arg0, b"HUNTER", b"Killua", b"X hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmek7G9tE1JB3LX3N7pQrRJpq5AgHNLfjBg3uzRTvGgWSZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0098ca000feef115647c5e4e218b4ade30dc4c75961f0224eb8a9972e84f1a75de069c86e4ef2422af52f6808a01102a631d72c16b7b2a3c9ceeca05351d896903f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743421474"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

