module 0xf4501548be5f58278fff27b6ead51d77f0059e07b953bfdfd6a69dbc5a9dfb77::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWW>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWW>(arg0, b"WWW", b"TEST3", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"01f2a442315814996119003bca98007e9678317261c14178d5d18f5d2c7bfff2ff3c386c44a42ca0250fa74ff2f8a19c07e44961f9a1b91420a0a362baaea16e075bcf13243c9147d8b3f36a090247f36739c73fb3fe621d88342344593c5918101743676643"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

