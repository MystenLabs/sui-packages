module 0x46f76ae44444ea6e6bbf1c59d8e22ae1d5777bfbf3a228d20c4970c25568b1dd::omega {
    struct OMEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMEGA>(arg0, 6, b"OMEGA", b"OMEGASUI", b"/fuelforsoulsseekingmaxpower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_C5ws_Kz682s8_By_Y_Lx_Vp_Y8_J3_GHSAH_Ts_T4f_J_Pf_T97_Npump_71f3388efe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

