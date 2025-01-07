module 0x1e9a3f2af6df4d74d6a0ae71932a60e5f91b83edf03ffe149ae151ec0bcaa8a::dickdog {
    struct DICKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKDOG>(arg0, 6, b"DICKDOG", b"Dick Dog", b"The dog's dick is the first coin accepted in all nearby galaxies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Lwgk_ZAG_Ck_R_Fb_XQ_Bm_I_Xm_LS_33_MI_Wx_SHF_1gll_Pv_YP_Yqdl_Y_Bt_a_Mq_Xv_Da_K3_If1b_KG_Orv_Wg_Q30_V_f24914a03a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

