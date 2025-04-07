module 0xde4a1ebf7cd9581306a559b0660f9f4ed4c7a701e584440c7ecbe0a29218c655::tstdd {
    struct TSTDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTDD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TSTDD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TSTDD>(arg0, b"TSTDD", b"TESTDD", b"test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc1RhKBHoHXgu4XZ7ANXneqDj8zLk5ZrjVEmazyHY9y8e")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0030ac2412d13aa3b24ede14c1a1cf331c57bc54b6a07eed72fa799071efb44e4608f722b64adfc48c9dc812761d0edda940fa32e01aa5033356f0eac87c6d470df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744016840"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

