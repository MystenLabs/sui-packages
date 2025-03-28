module 0x25b5f138c5f9e490beb98ab90fce6a1d25f4bfad55754adca17fe21fc80b7771::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<HI>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<HI>(arg0, b"Hi", b"Hisoka", b"hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmefH5ParXM3VBuH1pZsBepeo1GVLZkbKxoaq74VcfwuDY")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d25535dbb965d575691547ac7f7ea886ed559527b97fd3f42d3bdda7ca471fc2d31fb940fd6b1417f962d536a62a1f0521a06d4fae122b92458bc821f821ef06f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743163574"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

