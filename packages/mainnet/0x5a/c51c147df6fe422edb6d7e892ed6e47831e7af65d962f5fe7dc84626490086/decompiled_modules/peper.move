module 0x5ac51c147df6fe422edb6d7e892ed6e47831e7af65d962f5fe7dc84626490086::peper {
    struct PEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPER>(arg0, 6, b"PEPER", b"PEPEAVER", b"Pepe in beaver suit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O8vid_T_AMH_Alc_Zvkfx_WZ_My4xc3_Aw28_Ruv_8_Db4_YN_7_U_ts_Jh_o_JIMYC_Murh_S_Qem_DQC_8lid_Ri_Pd_G4_I_Jlx_Xe_DNM_3_Yt_Ela_MB_Iwp_P_Ab_LQA_d4d009e3a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

