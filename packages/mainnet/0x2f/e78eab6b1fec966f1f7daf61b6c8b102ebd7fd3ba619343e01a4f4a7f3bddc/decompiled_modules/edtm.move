module 0x2fe78eab6b1fec966f1f7daf61b6c8b102ebd7fd3ba619343e01a4f4a7f3bddc::edtm {
    struct EDTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDTM>(arg0, 6, b"EDTM", b"Ever Dream This Man?", b"Ever Dream This Man? Have you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Pj_Rs_Son_X7q_DD_Qnn_V7_QW_Yp3cd_HFCVRZ_Cb4_T61_K9_Zy_U_Sf_b58aa7ae4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

