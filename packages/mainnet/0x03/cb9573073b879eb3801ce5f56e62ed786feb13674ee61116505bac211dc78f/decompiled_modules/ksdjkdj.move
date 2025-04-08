module 0x3cb9573073b879eb3801ce5f56e62ed786feb13674ee61116505bac211dc78f::ksdjkdj {
    struct KSDJKDJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSDJKDJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<KSDJKDJ>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<KSDJKDJ>(arg0, b"KSDJKDJ", b"sajdklasjd", b"DSADJLK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0050a7c5aa0fb618e70c94aeeaa00319c55bb8784eebc80acebc50175f8e4c3ad3231c90856cb6fb0d61e779f7fc2087ffbb58bdf88f0365ea5ef248cf94952f04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111876"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

