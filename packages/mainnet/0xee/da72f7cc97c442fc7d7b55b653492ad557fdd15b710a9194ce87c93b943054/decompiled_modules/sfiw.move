module 0xeeda72f7cc97c442fc7d7b55b653492ad557fdd15b710a9194ce87c93b943054::sfiw {
    struct SFIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFIW>(arg0, 6, b"SFIW", b"Dog wif shapka", b"Inspired by the Shiba Inu memecoin trend, the project chose a Shiba puppy wearing a pink beanie as its mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_HR_0c_HM_6_Ly90d_Gwt_Zn_Jvbn_Rlbm_Qtcz_Mtc3_Rvcm_Fn_ZS_5z_My5hb_WF_6b25hd3_Mu_Y29t_Lz_E3_M_Tkz_MDY_2_MTI_1_Mz_Rf_SU_1_H_Xzg3_O_Tguan_Bl_Zw_75da9decb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

