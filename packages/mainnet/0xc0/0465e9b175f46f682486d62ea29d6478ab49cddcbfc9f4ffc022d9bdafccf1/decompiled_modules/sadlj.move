module 0xc00465e9b175f46f682486d62ea29d6478ab49cddcbfc9f4ffc022d9bdafccf1::sadlj {
    struct SADLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADLJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SADLJ>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SADLJ>(arg0, b"SADLj", b"SLDJ", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0052584881cecd622daf69dd910d83288da6a5cadcf2f455f3d4bf83b7fbede5f1cd7e09dc24dc37ea01520fe39117df634504b50ad2c339e58a0cfa8061923001f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112128"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

