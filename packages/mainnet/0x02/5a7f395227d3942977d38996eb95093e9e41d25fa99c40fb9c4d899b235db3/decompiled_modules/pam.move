module 0x25a7f395227d3942977d38996eb95093e9e41d25fa99c40fb9c4d899b235db3::pam {
    struct PAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAM>(arg0, 6, b"PAM", b"SuiPam", b"Pam the bird.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PV_Cce_WA_Ect_Kt_G9c1_Q_Eg_HU_Km_U_Dep_Lcf7_T_Djy_K_Juj_P_Dn_Mo_8db65e4cd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

