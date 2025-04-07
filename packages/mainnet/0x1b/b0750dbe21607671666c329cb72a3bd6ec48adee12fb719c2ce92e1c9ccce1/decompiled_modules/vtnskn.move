module 0x1bb0750dbe21607671666c329cb72a3bd6ec48adee12fb719c2ce92e1c9ccce1::vtnskn {
    struct VTNSKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTNSKN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<VTNSKN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<VTNSKN>(arg0, b"VTNSKN", b"VTNSKNA", b"this is VTNSKNA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeddjFzxP5Tg4mgPh9JGFWVaoJauR3AfFkb57K77vfUwN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bb5cbe2c637cb7012762b340ed31dda48051967beb297f881f4e7678cb5323e4e90c3c082c29a2fabee158b29552edab50573a44e5f24e2c04e73412ef95ca04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744018729"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

