module 0xf386c1e815db8fb213a4feabb2efeee33fa9437fc615dadadbe675dd3082fa74::wwc {
    struct WWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWC>(arg0, b"WWC", b"TEST6", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0057776438654214dc888398e6a1080e5f910548cd87e96cec5e95ab0284fa855bdfd804f5c32038ac228c9801670d68a320abe3cbe10ae1bb46172cbeb84812097b08d9209dea8e2521b5e3f461f27ccd9b2ac43433f9f61559a0ee890e4e72851743601094"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

