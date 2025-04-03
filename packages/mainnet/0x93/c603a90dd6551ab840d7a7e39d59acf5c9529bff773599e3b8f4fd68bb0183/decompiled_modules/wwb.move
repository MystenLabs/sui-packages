module 0x93c603a90dd6551ab840d7a7e39d59acf5c9529bff773599e3b8f4fd68bb0183::wwb {
    struct WWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWB>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWB>(arg0, b"WWB", b"TEST5", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ce3dd3c1a77a62dc64453ec5a3a5940a853af5f495d3ae5221348c38240281bf6cc97efde86a2b762f2f3af9ae61a1a302965a1cba1af1c55802d59c802bb1017b08d9209dea8e2521b5e3f461f27ccd9b2ac43433f9f61559a0ee890e4e72851743677667"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

