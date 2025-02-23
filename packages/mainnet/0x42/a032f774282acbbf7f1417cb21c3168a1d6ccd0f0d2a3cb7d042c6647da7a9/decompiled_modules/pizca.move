module 0x42a032f774282acbbf7f1417cb21c3168a1d6ccd0f0d2a3cb7d042c6647da7a9::pizca {
    struct PIZCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZCA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PIZCA>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PIZCA>(arg0, b"PIZCA", b"Pizza", b"The Pizza 4 sira maseratti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc3FH6TPgh7BuV3tw1x2LZhJENxDLx527pRTktbyjaJaD")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e16b371ef0b550f05c7c74b5d3c24dca1b7712b242dd46116086a22fc19b33cc9cb4c8f70e16bc64e0e1614d296ca25d834a2f6e81ebd156adbd441c1c49ba0cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740320168"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

