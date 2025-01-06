module 0x13dbdbb17baeaff1d0d8a377f5b7770faf2969b92d219422d95774410c9ee28c::picoin {
    struct PICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PICOIN>(arg0, 6, b"PICOIN", b"picoinha by SuiAI", b"pi breaking barries ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/360_F_804357041_w_E6_Xg0l_F_Hss2_X6_Uj_Myz_KE_8_Lm_X_Iuds_MUF_21e30f3ebb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PICOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

