module 0x97557f47521902856d5ed8f5a458d3d1ea6f34b1c2566ed4d797379627f17ee8::magic {
    struct MAGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIC>(arg0, 6, b"MAGIC", b"USELESS MAGIC INTERNET COIN", b"LAUNCHED ON SOLANA USELESS MAGIC INTERNET COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Uwz_P3_Sw_Lwe_Y5n_T_Wk_Uj_U5s_DGM_Yow_UCP_Mfpv8be5r_F_Ncn_1_1_1d76b12903.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

