module 0x296add4d5eef405e3f574ddb0e74f83ef65695d55b315612e0517bbae149e0bb::doga {
    struct DOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DOGA>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DOGA>(arg0, b"DOGa", b"DOGa Token", b"dog token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeddjFzxP5Tg4mgPh9JGFWVaoJauR3AfFkb57K77vfUwN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0046838e0a04d01e8389c0599a5ceb09449ec0bde91bb484536f8779db31a2f6d66d6d3280216277375e3c7ce6bf785ba931862597f62ccd9291fd190c5aeed100f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744092291"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

