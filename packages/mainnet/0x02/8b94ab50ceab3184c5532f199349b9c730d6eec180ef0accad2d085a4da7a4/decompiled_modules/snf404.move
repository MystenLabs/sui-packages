module 0x28b94ab50ceab3184c5532f199349b9c730d6eec180ef0accad2d085a4da7a4::snf404 {
    struct SNF404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNF404, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNF404>(arg0, 6, b"SNF404", b"Satoshi Not Found", b"404 Satoshi Not Found", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pf_YTX_2ec_RZ_Wi_NJ_Gq_J7_Wwjz_Lcs_GR_Qshut_He_Jy2_Xj_XB_4_Lo_0bc6383d89.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNF404>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNF404>>(v1);
    }

    // decompiled from Move bytecode v6
}

