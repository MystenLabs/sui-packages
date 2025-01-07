module 0x692e74219b512ec45127a7bfa347e93ffeffa3ed93055f0332a086bbc211a582::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"SENSUI", b"SENSUI TOKEN", b"HE IS THE SENSEI OF SUI. HE IS SENSUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cartoon_style_illustration_of_a_chinese_sensei_w_x8_YW_7og_PR_Uyb_MKQ_Jet_QWBQ_4ctq0_t_Qsu_ZHC_1q_WU_3_P_Iw_8c7e36de9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

