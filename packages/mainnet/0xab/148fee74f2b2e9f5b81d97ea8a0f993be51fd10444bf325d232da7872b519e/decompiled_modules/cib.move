module 0xab148fee74f2b2e9f5b81d97ea8a0f993be51fd10444bf325d232da7872b519e::cib {
    struct CIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<CIB>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<CIB>(arg0, b"CIB", b"CIBYR CITY", b"CIBYR CITY A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb9BfbDn1VhkyL6Daxj43Yh65EdYyd7GfQsy8A2nQDoD2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ca9e5a71c3bef9241264b4bc1cb8e535f58e53dabb0f53d4c66efb8b6747ebd76146cdbe0bc00238c50e1be5bb9d75d27fd0e9fc9bf0947402984dc087316d0cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740175476"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

