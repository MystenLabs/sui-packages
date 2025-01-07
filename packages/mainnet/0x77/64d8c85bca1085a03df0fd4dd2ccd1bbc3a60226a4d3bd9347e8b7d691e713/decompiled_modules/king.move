module 0x7764d8c85bca1085a03df0fd4dd2ccd1bbc3a60226a4d3bd9347e8b7d691e713::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"THE KING", b"KING ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmec_W5q_Ksp_Xfj_Xqn_V_Tzbbxjvs_ZH_2_Cdxteks_T_Ht_MG_6_A_Mmm_N_46a177a824.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

