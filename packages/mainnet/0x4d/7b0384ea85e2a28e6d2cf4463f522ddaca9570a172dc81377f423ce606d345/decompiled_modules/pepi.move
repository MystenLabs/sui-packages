module 0x4d7b0384ea85e2a28e6d2cf4463f522ddaca9570a172dc81377f423ce606d345::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 6, b"PEPI", b"pepi", b"pepi is popo's cousin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Ns4_Za_LP_Wk_Z_Xt67w_V_Lp6_Lryruwys_Xv_DUL_Kx_F1mm4gs_WK_22829c6318.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

