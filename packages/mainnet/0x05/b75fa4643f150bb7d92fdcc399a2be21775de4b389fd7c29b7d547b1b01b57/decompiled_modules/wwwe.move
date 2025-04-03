module 0x5b75fa4643f150bb7d92fdcc399a2be21775de4b389fd7c29b7d547b1b01b57::wwwe {
    struct WWWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWWE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWWE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWWE>(arg0, b"WWWE", b"TEST", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeddjFzxP5Tg4mgPh9JGFWVaoJauR3AfFkb57K77vfUwN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0011620beff016d89541770368f8c2fabeab347220c93f584c44d919be4e8641b72f777cab552f80c2c76794c4d2273c4a5b27b442f03b6f4a8b3cfd577fab15047b08d9209dea8e2521b5e3f461f27ccd9b2ac43433f9f61559a0ee890e4e72851743680027"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

