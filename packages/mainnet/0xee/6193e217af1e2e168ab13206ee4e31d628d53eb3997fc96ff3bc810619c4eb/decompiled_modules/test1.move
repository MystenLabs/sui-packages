module 0xee6193e217af1e2e168ab13206ee4e31d628d53eb3997fc96ff3bc810619c4eb::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TEST1>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TEST1>(arg0, b"Test1", b"Tttt", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f903dbf0b70b2797d3ae46f3f830ae21aabc998db4eee24f479cac567dc4f197228ad64f8f18107a8309dab3aa050240ca3abab690b508a26d14ea1f6d75c80af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744014626"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

