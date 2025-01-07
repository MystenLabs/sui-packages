module 0x37ccddc69ff125517d8f7c69a1f74ed8325a203c40bb540c716192a1cb32f66d::erbai {
    struct ERBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERBAI>(arg0, 6, b"ERBAI", b"ERBAI ai robot", x"0a45524241492074686520666972737420616920726f626f7420746f206b69646e6170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh_Cx_PN_Tirk_TT_5_TE_8jn_Bhtca_S6n_Tc_Hp8_Zh_Pw_Kggj_Apump_3114528400.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

