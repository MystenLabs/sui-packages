module 0x204b1535e62e0226e6b2d1e417da609d64198ecf4355c0e83de05cc4e5e03191::city2 {
    struct CITY2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CITY2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<CITY2>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<CITY2>(arg0, b"CITY2", b"CIBYR CITY", b"CIBYR CITY2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb9BfbDn1VhkyL6Daxj43Yh65EdYyd7GfQsy8A2nQDoD2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004f3fc937b7b02b923adb76b8c4edf9f3f1bf52f37976bc862cbeb0fd3ca7ff01863d587cbf424454b24342b110028e920c3722a8497e5e05b01051b2382fe305f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743078215"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

