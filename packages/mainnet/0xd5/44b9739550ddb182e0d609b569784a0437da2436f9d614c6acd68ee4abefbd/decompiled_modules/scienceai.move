module 0xd544b9739550ddb182e0d609b569784a0437da2436f9d614c6acd68ee4abefbd::scienceai {
    struct SCIENCEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIENCEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCIENCEAI>(arg0, 6, b"SCIENCEAI", b"Science AI", b"Methodologist, Executor, Evaluator, Visionaryfour forces forging boundless AI. Each role expands the horizons of intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xz26nz3cjfpf_Bz_U_Zdf92s_Ptajg_Zp9_L3s7_N_Srk7_K_Zi_T_Ue_671536c44f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCIENCEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCIENCEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

