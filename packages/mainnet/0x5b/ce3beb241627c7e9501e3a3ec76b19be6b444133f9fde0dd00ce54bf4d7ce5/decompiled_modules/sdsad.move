module 0x5bce3beb241627c7e9501e3a3ec76b19be6b444133f9fde0dd00ce54bf4d7ce5::sdsad {
    struct SDSAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDSAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SDSAD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SDSAD>(arg0, b"SDSAD", b"SALDKJ", b"sadsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002726d16fc3a1d90c3e10ca0f563e8aa63b990042def68f8d9984839a3317b63cfde2742c2d5760f94c0b5b0803264fbf6b259dab2038fca8b8bf78bd28484203f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112348"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

