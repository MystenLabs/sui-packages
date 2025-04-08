module 0x866b829663dd2e8699cb898aa66565c858f27ad68eb76e6652fe9ac38d1152b4::jksjdk {
    struct JKSJDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKSJDK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<JKSJDK>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<JKSJDK>(arg0, b"JKSJDK", b"DJSKJD", b"DSKJdksjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003b9840d455c54134b902f67fd65bd786ea77cf60f473b2f735935defdf4aed3822fcac3ef2d0bf4711bd7746726d0d24b36a31afbb84960f3f76de3fd3be3c00f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111761"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

