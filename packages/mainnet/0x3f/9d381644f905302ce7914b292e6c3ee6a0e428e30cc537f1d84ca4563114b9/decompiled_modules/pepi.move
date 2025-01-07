module 0x3f9d381644f905302ce7914b292e6c3ee6a0e428e30cc537f1d84ca4563114b9::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 6, b"PEPI", b"pepi", b"pepi is popo's cousin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Ns4_Za_LP_Wk_Z_Xt67w_V_Lp6_Lryruwys_Xv_DUL_Kx_F1mm4gs_WK_4d6484e732.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

