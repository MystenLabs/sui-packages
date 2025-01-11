module 0x4f4580b54b275c4076125255261e0a2541d5a211a0837e98a18649ac71bbfb0d::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"SUI KIKATO", b"SUI KIKATO is An aspiring digital artist who comes to life, engages, and joins in on her journey to become the first international AI IDOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme33e1_DL_9_TKS_6r_Qs_Vufqsx_Rv_Xr_Fnm_La_Gcs_Xt_J9_E_Tr_K_Ka_L_12879db79c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

