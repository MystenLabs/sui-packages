module 0x92defacc1698104b893e6142dfb22f0f03c33bdfedf84c223e354f19a9d70a7b::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro2.0", b"THE NEW SHIBA INU Adopted BY KABOSU MAMA AND OFFICIAL SISTER OF $DOGE, A MEME LEGEND, HAS ARRIVED ON THE ETHEREUM CHAIN TO MAKE HISTORY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PZN_1_W_Hty_Gs_Nu_DY_5_W_Drx9_Jsf_B_Cz_KF_3g_ERB_Uc7v_J_Ed_FQ_2_K_45ff77c3a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

