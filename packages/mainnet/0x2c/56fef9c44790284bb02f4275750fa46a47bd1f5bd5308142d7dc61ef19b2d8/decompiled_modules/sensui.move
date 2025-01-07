module 0x2c56fef9c44790284bb02f4275750fa46a47bd1f5bd5308142d7dc61ef19b2d8::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"SENSUI", b"SENSUI TOKEN", b"HE IS THE SENSEI OF SUI. HE IS SENSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cartoon_style_illustration_of_a_chinese_sensei_w_x8_YW_7og_PR_Uyb_MKQ_Jet_QWBQ_4ctq0_t_Qsu_ZHC_1q_WU_3_P_Iw_99513fbcb9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

