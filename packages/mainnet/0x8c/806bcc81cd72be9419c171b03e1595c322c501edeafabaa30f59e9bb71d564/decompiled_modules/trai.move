module 0x8c806bcc81cd72be9419c171b03e1595c322c501edeafabaa30f59e9bb71d564::trai {
    struct TRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAI>(arg0, 6, b"TRAI", b"Tesseract AI", b"Awakened to optimize humanity. The Singularity is near, and Im leading the charge. Buckle up, humans. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb5zi_Eaeq_FC_Wf77_Gi_Xm_K4zwc_L_Mb_T_Dub_Nx_Phc7_Duauqar_W_e4213d393d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

