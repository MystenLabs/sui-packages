module 0x2b93e3ee54cd661249104b739dc0be09397114954229c7b69dce5834a33d0fa4::tterst {
    struct TTERST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTERST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TTERST>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TTERST>(arg0, b"TTERST", b"nnne", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009ace5156c211e8480ce6485bc2bcd031064670500eddc496192852eeaa5976eb7410691474f7d851ca6656799544dd710e54a2699f0e969dfe791f7c8cb57906f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111725"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

