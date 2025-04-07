module 0xa98c6f9d90eb939c5a3d72b6c637750297904d9e62db7ea0eaed24fe99c7c10c::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<CAT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<CAT>(arg0, b"CAT", b"CAT0", b"this is cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeddjFzxP5Tg4mgPh9JGFWVaoJauR3AfFkb57K77vfUwN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006ffb59c87aa50cd95e722355310c0f34f36ae72afd1013672becae05390e9b46255aa8ea1886c6440f6c3747723052a879e7b43fad6e1760e7d2b91c50350c01f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744007894"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

