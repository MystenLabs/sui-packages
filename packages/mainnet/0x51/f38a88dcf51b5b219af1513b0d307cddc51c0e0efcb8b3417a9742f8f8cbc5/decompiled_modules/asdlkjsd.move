module 0x51f38a88dcf51b5b219af1513b0d307cddc51c0e0efcb8b3417a9742f8f8cbc5::asdlkjsd {
    struct ASDLKJSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDLKJSD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<ASDLKJSD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<ASDLKJSD>(arg0, b"ASDLKJSD", b"SDLKJ", b"asdjkasld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005ebc40485979e28af52deaf784eb7b08b817ae8ce210f3e36d357b81a5458bdad51dea4d93ec1c26e01ad28c96cc59c99c952e3572dd5cecb229df35ad2aa007f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112589"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

