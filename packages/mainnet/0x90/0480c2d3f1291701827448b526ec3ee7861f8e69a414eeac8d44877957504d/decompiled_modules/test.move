module 0x900480c2d3f1291701827448b526ec3ee7861f8e69a414eeac8d44877957504d::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TEST>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TEST>(arg0, b"TEST", b"nnnte", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0043495dffbad0604d984c8d1490bb1126f2d6b3820ade58c9fbc3655c6e0762dca4b6f235378f738c71af3c377a9e9504d147c0a8f106105c0fe693a4d430e904f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112895"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

