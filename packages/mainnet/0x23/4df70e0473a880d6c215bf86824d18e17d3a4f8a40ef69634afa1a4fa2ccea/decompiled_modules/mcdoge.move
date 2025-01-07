module 0x234df70e0473a880d6c215bf86824d18e17d3a4f8a40ef69634afa1a4fa2ccea::mcdoge {
    struct MCDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDOGE>(arg0, 6, b"MCDOGE", b"McDoge", b"McDoge($MCDOGE) is ready for the great adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V2o_Ne_Kp_Lh1_CC_Dxav_S_Be_Jxsmbob_G_Az_HYWK_Cb_KY_8g_Fd2fo_5aa459dabb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

