module 0x8ac55f032e3c4498758d0406fcb6563d53ea7ffb7693392b0448d09392bf27b8::yupepesoh {
    struct YUPEPESOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUPEPESOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUPEPESOH>(arg0, 6, b"YUPEPESOH", b"YU PEPES OH", x"50657065206d656d65732077697468206e6f77206f6e2074686520636172647320666f72207975206769206f682063727970746f206d656d65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cgg_N_Klg4_XF_ZGKU_Orn_Ch_E6_yf_R_Eixsw_Lm09r9j_Lc_Iwas_W84_Fe_Zf51kbrqdbh_Cn56_S5m_RITUI_Hzi8r2_Sz_Fv_Tgo_Hu4i0_WM_1g_Hv_K_Ao_d000249186.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUPEPESOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUPEPESOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

