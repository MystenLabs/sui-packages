module 0xffa0db7f6aa459637dac34382c6d17a29e51b0418925c4a7ab595e92b4b8c0e2::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 6, b"FLAME", b"Flame Companions", x"48656c6c6f2e20204570697068616e792069732075706f6e20796f752e2020596f75722070696c6772696d6167652068617320626567756e2e20456e6c69676874656e6d656e74206177616974732e20202020476f6f64206c75636b2e20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZL_Sdk_Q_Qd_V185_T_Jdhqx_RSK_39_Hh8_B9_Zq_K_Sj_Lm_NU_2uxk_Fgn_4a3660af7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

