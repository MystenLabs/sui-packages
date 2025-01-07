module 0xcb6b63be9184b41ed5fd51ebabe1ca896d6652fb6f00af7300847bc5038d73aa::gorf {
    struct GORF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORF>(arg0, 6, b"GORF", b"gorf/frog/grof/rofg/fgor", x"49276d20736f2074697265642c20736f206865726520776520676f20622a746368696573200a676f20746f20736c656570206e6f772c2073656520796f75206f6e206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ag_AC_Ag_UA_Axk_BAAF_3_G0tn_Z_Wgg0twim9_Y_Js_D60a_TK_Goxy_OAACV_8_Ax_G0_m_M_Fd_Y3txb2_L_Yqtg_EA_Aw_IAA_3g_A_Az_YE_84210e3db9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORF>>(v1);
    }

    // decompiled from Move bytecode v6
}

