module 0xbf028123cfdb36e2bb96f6acef54cc904ef3f66b47bcd6473daf8f307659a1f9::boba {
    struct BOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBA>(arg0, 6, b"BOBA", b"BoBa", x"54686520717565737420746f206765742068696768657220616e64206869676865722068617320626567756e2e204669727374207265616c65737420424f4241206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W1_Xixw_Tz_Ktx_DY_8_SZ_Ed_AP_5sb_L_Nd35phc_XQ_Vb5_MD_Dx_P_Lo4_4a010e416c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

