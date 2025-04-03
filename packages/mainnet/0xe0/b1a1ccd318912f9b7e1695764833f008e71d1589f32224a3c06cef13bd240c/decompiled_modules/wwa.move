module 0xe0b1a1ccd318912f9b7e1695764833f008e71d1589f32224a3c06cef13bd240c::wwa {
    struct WWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWA>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWA>(arg0, b"WWA", b"TEST4", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c08201f805a82f5fbe973d2cce73ea809d5ef629b44c7ea3ec03a113f1caff560e11cbe0e363a03e573bf3e3ff9fc6092f5ba65aed8973b5ddca8c8f5cd1650b5bcf13243c9147d8b3f36a090247f36739c73fb3fe621d88342344593c5918101743677157"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

