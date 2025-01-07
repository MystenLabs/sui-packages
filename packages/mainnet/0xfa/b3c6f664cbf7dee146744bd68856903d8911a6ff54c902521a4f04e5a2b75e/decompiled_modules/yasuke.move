module 0xfab3c6f664cbf7dee146744bd68856903d8911a6ff54c902521a4f04e5a2b75e::yasuke {
    struct YASUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YASUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YASUKE>(arg0, 6, b"YASUKE", b"YASUKE Ya Naikai", b"$YASUKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SU_Hgp_Ts_Qx_T8_EYK_5s_WZU_Yeqtmz_Fem_D_Xj_Pr_Yi_Kn_KR_Mh_HF_6_66d16073b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YASUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YASUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

