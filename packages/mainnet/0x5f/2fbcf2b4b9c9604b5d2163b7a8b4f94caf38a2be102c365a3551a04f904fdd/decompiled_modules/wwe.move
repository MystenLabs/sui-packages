module 0x5f2fbcf2b4b9c9604b5d2163b7a8b4f94caf38a2be102c365a3551a04f904fdd::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWE>(arg0, b"WWE", b"TEST8", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0093bbfcbce74aebbe4e88fd07b6bd803f4246670e789714fe1c15844186fda21b2ed46c81fcd12cd47d631f9c4eec63876390d1820bffc7e3dc45707eb4621101aac7981e520fe4d608514382220b65e9590f2e7d4cb83c958c1c6ec69d6af9971743679793"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

