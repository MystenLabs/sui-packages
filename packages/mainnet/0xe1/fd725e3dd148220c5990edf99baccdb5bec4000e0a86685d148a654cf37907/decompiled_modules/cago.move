module 0xe1fd725e3dd148220c5990edf99baccdb5bec4000e0a86685d148a654cf37907::cago {
    struct CAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAGO>(arg0, 6, b"CAGO", b"GAGOONSUI", b"$CAGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Zsn_NR_Jwmr_Cq6jpnw3_Hcox_Zj_Zwnz8as3v_Jkx_F8_Gdo_WC_7_23ec8e1fa5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

