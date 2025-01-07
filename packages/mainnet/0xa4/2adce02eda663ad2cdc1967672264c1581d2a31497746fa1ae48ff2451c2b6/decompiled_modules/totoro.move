module 0xa42adce02eda663ad2cdc1967672264c1581d2a31497746fa1ae48ff2451c2b6::totoro {
    struct TOTORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTORO>(arg0, 6, b"TOTORO", b"Totoro", x"596f7572204e65696768626f7220546f746f726f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z7_Mr_HJXN_6_BNA_Ev_P_Bo3_Y_Hx_Wxz6tu_Fo1p_UP_Mb_W1_Y2_Es_Lt1_7545c0ec8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

