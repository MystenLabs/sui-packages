module 0x73ea3c6acb7d88713932fa747711a0932fec9922871e8aab4dbc2a5c9ceafa1::dvs_mvhp93yo {
    struct DVS_MVHP93YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHP93YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHP93YO>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhp93yo"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHP93YO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHP93YO>>(0x2::coin_registry::finalize<DVS_MVHP93YO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

