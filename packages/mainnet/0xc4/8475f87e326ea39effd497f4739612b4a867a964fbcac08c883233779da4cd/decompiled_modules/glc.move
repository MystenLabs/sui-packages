module 0xc48475f87e326ea39effd497f4739612b4a867a964fbcac08c883233779da4cd::glc {
    struct GLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLC>(arg0, 6, b"GLC", b"GlitCh", x"476c69746368206f6e2074686520636861696e2028474c43290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmat4_A67_Niy_HRD_54_Rqk_H_Yx4m_Gvrksbu_P9_U3_XH_Gyk_MKA_9_QC_6ab91a5cbc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

