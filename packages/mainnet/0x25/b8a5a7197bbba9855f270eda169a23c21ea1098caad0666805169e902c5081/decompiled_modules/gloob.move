module 0x25b8a5a7197bbba9855f270eda169a23c21ea1098caad0666805169e902c5081::gloob {
    struct GLOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOB>(arg0, 6, b"GLOOB", b"Gloob", x"474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G6b_VV_Gw_RWF_6_Mcd9z8_Lcb_V_Msg_Wa_TGJ_Go9_WAKM_Nx_G_Gpump_b9db34c4c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

