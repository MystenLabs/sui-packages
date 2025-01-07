module 0x96686aa07993e83a668123e552aac4fe4d88c6c995929ca22cc09c93ce314764::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Satoshi Not Found", b"404 Satoshi Not Found", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pf_YTX_2ec_RZ_Wi_NJ_Gq_J7_Wwjz_Lcs_GR_Qshut_He_Jy2_Xj_XB_4_Lo_42a79b0a07.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

