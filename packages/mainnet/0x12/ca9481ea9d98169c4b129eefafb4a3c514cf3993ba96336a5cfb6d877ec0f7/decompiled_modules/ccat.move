module 0x12ca9481ea9d98169c4b129eefafb4a3c514cf3993ba96336a5cfb6d877ec0f7::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 6, b"CCAT", b"Cryptocat", b" CryptoCat $CCAT is on fire! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Sx2w_NM_4m3_Va_Nv_MC_Bx_ZZZ_2wb_C_Kj_N2v58gd_Gw_Xad_Jdhaw_1a55e62eb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

