module 0x93e53e1504f03c00c55aea56556cea4a45a1b388f5c9b3d77b7d2c506502e65f::lols {
    struct LOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLS>(arg0, 6, b"LOLS", b"Lobster On Lion", b"Lobster On Lion - LOLS These two pieces will go viral", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wfaj_H_Nk_M6ceq_JBQ_6owzr_Ks_KLXJ_Vc_R31_Bg7_Ye_PJJ_Xb9kt_f636da88c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

