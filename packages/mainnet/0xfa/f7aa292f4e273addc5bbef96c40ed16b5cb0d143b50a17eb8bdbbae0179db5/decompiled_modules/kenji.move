module 0xfaf7aa292f4e273addc5bbef96c40ed16b5cb0d143b50a17eb8bdbbae0179db5::kenji {
    struct KENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENJI>(arg0, 6, b"Kenji", b"No1 Vine Dog", b"Meet Kenji, the most popular dog on Vine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sru_P1_Jm_Ze_X_Vwm_Kfsu_TB_Xm1_Dw_MZTH_5s_W567f_H3jv_WE_Du_G_aacbe3c8c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

