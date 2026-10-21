module 0xbf73f49477f4778025a3dd3dd4db76ac97549fe232bd34cc823d236d2a522fc7::dvs_mvhpuhio {
    struct DVS_MVHPUHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHPUHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHPUHIO>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhpuhio"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHPUHIO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHPUHIO>>(0x2::coin_registry::finalize<DVS_MVHPUHIO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

