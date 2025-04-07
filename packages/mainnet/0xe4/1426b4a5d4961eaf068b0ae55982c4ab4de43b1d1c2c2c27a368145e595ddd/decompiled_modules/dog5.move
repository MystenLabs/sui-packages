module 0xe41426b4a5d4961eaf068b0ae55982c4ab4de43b1d1c2c2c27a368145e595ddd::dog5 {
    struct DOG5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG5, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DOG5>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DOG5>(arg0, b"DOG5", b"DOG Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00525010c7d720b88dbdb6cb3aeadede53305f21959b345b31bf5c80d31f7070b6455eba3b4c2302c2a42eee8d27b66346252d96211dadc8466668feffe9e80605f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744014895"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

