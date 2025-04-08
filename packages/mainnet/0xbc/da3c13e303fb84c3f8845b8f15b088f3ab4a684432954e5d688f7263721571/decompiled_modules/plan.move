module 0xbcda3c13e303fb84c3f8845b8f15b088f3ab4a684432954e5d688f7263721571::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PLAN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PLAN>(arg0, b"PLAN", b"Palaneta", b"Rasta Palaneta PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0011997e68d061bba31f133613af058d89040b1a8c9e33dcdbacefee73e4e2b1141368aff01f155ad149428297e2acb0ca0d4ebc49514a7bdc0438e71c471f4000f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111381"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

