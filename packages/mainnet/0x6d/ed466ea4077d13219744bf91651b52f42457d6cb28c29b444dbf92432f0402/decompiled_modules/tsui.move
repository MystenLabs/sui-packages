module 0x6ded466ea4077d13219744bf91651b52f42457d6cb28c29b444dbf92432f0402::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"Tsui", b"Tinder Suindler", b"The Tinder Suindler is a about Suimon Leviev, who used dating apps to con women into believing he was a wealthy businessman, ultimately swindling them out of hundreds of thousands of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAAA_Qa4_RN_Sg511x_Bq7fmflr_Tlj_R_Qi_P7_D_Hz0_RA_0_y4ju6_Xf8od_Rt3_Ihj_C_cxq_U5z6x_WSMK_Iri_L_Ghf_KHH_Khq_M5v5_A_Wki9scs_K_Wh_M87obf_R_Oz_Pg8fj02_M_Nh_s_Y1_Is_Txyt_BI_4_Dd_A9o9_Se_Vpo7i_Rte_JC_1c_ASNT_9c_baa1ec9797.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

