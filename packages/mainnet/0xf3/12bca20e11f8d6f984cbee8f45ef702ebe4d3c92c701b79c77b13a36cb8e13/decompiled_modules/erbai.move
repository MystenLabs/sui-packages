module 0xf312bca20e11f8d6f984cbee8f45ef702ebe4d3c92c701b79c77b13a36cb8e13::erbai {
    struct ERBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERBAI>(arg0, 6, b"ERBAI", b"ERBAI ai robot", x"45524241492074686520666972737420616920726f626f7420746f206b69646e61700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh_Cx_PN_Tirk_TT_5_TE_8jn_Bhtca_S6n_Tc_Hp8_Zh_Pw_Kggj_Apump_90bfadd6ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

