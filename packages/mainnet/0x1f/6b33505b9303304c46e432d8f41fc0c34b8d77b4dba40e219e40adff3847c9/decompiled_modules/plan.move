module 0x1f6b33505b9303304c46e432d8f41fc0c34b8d77b4dba40e219e40adff3847c9::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PLAN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PLAN>(arg0, b"PLAN", b"Planet", b"Planet Earth ss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0055732139534c3170fcb6709ade603fb1489f4199d9a33b085b7c987dd29031dea4fd76c8a9f3dd8d6538fa3ce31eef9237ac61b63082d7adb892cc7074f26101f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111718"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

