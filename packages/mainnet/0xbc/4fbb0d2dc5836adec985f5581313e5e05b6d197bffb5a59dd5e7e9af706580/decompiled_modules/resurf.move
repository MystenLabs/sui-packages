module 0xbc4fbb0d2dc5836adec985f5581313e5e05b6d197bffb5a59dd5e7e9af706580::resurf {
    struct RESURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESURF>(arg0, 6, b"RESURF", b"AI Scene Reconstruction Sim", b"Resurf is a cutting-edge AI platform designed to revolutionize context reinstatement and scene reconstruction. By combining advanced artificial intelligence, natural language processing, and 3D modeling, Resurf generates immersive simulations from textual descriptions, sketches, or other data inputs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sz8_Nfxf_NR_Hvsq_Yo_VRHD_Bn_GY_3_CE_Caa_G4_TJ_9z_Bh1g_Hn4_TM_230a2c666e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RESURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

