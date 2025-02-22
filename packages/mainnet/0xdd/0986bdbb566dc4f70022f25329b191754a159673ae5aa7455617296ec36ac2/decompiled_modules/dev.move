module 0xdd0986bdbb566dc4f70022f25329b191754a159673ae5aa7455617296ec36ac2::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"China DEV", x"4368696e612044652056656c6173636f0a406368696e616465760a4d616b6520757020417274697374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Usd_NFV_Jd_PU_1w_Eg_Szyn8_C3a_L1y_BXGDW_Bwi_Xqh_Wasu_Rq6_37550f246c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

