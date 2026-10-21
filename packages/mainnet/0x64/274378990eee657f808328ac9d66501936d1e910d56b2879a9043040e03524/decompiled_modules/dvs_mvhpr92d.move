module 0x64274378990eee657f808328ac9d66501936d1e910d56b2879a9043040e03524::dvs_mvhpr92d {
    struct DVS_MVHPR92D has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHPR92D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHPR92D>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhpr92d"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHPR92D>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHPR92D>>(0x2::coin_registry::finalize<DVS_MVHPR92D>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

