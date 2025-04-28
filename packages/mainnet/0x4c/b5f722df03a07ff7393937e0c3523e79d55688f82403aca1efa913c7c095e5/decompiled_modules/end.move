module 0x4cb5f722df03a07ff7393937e0c3523e79d55688f82403aca1efa913c7c095e5::end {
    struct END has drop {
        dummy_field: bool,
    }

    fun init(arg0: END, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<END>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<END>(arg0, b"End", b"The", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0005099d088722a5f25f199967871c45c2b350cfa503299926a14fa79b34ae0be5bdd4af1b77f321ea482f93181ec1984c1da2c9539793bd6192c427cca30c300bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745876117"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

