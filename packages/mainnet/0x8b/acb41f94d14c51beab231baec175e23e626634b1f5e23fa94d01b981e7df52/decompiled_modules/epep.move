module 0x8bacb41f94d14c51beab231baec175e23e626634b1f5e23fa94d01b981e7df52::epep {
    struct EPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPEP>(arg0, 6, b"EPEP", b"epep", x"4f6666696369616c2045504550206f662053756920636861696e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Wyb5_Ngkb_TT_Hm_F675xw6iq_P93a_YG_Go_Yy_TW_Cb_Qmz44_A9_N_cbe7b05874.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

