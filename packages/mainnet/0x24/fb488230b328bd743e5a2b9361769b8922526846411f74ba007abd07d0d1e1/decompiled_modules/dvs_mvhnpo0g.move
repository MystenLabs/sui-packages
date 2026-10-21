module 0x24fb488230b328bd743e5a2b9361769b8922526846411f74ba007abd07d0d1e1::dvs_mvhnpo0g {
    struct DVS_MVHNPO0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHNPO0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHNPO0G>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhnpo0g"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHNPO0G>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHNPO0G>>(0x2::coin_registry::finalize<DVS_MVHNPO0G>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

