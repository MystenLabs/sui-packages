module 0x7154a681402b04c6f6d1539ec76600bf7684e13e6a5a0c78dc81ff36f8a88565::miyabi {
    struct MIYABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIYABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIYABI>(arg0, 6, b"Miyabi", b"Miyabi Lofi AI", x"596168686f7e21204d6979616269206865726521204c657473206d616b6520796f7572206f776e206c6f666920626561742c206a7573742074656c6c206d65207468652076696265210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yf_CXN_2_WXRN_13_Kk_GVC_224_Mm_T_Ab72_Br_ZC_4_Tid_U_Zr_VEK_2b7_9c76cb79aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIYABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIYABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

