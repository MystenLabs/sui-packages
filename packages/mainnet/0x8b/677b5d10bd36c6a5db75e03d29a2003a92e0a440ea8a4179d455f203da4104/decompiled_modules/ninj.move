module 0x8b677b5d10bd36c6a5db75e03d29a2003a92e0a440ea8a4179d455f203da4104::ninj {
    struct NINJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJ>(arg0, 6, b"NINJ", b"Satoshi AI Ninja", x"5265766f6c7574696f6e697a6520796f75722074726164696e672077697468204e696e6a6120207468652041492d706f77657265642054726164696e67204167656e74207365616d6c6573736c7920626c656e64696e6720414920616e64204465466920666f7220736d61727465722c206d6f726520656666696369656e7420737472617465676965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P3_Nrw_Hnv8b_Hj_Gd1_PYL_1_Q4i7_X_En8_MH_6g_WA_Jrgrk_H_Mf_E1a_b8e1e8a0df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

