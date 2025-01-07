module 0x8f8cfa32634100f339ccac6c3130dd33f50605681a99f674bcc28bcce9fb296::tygo {
    struct TYGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYGO>(arg0, 6, b"TYGO", b"TYGO ON SUI", b"HELLO IM TYGO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Hnqys_G39j_Y_Nf_TEAK_3f_SPJ_Ms8_YSXQ_Yv_R58_HTP_6vypump_67e2870b66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

