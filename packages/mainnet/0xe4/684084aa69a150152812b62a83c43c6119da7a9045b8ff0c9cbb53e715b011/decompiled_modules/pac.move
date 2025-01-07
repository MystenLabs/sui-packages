module 0xe4684084aa69a150152812b62a83c43c6119da7a9045b8ff0c9cbb53e715b011::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"America PAC", x"54686973206973207468652050414320746861742049206372656174656420746f20737570706f72742063616e646964617465732077686f2062656c6965766520696e2074686520636f72652076616c756573206f6620416d6572696361202d2d2d20456c6f6e4d75736b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yva_XP_8awt_Vp_NA_Ebv_GGWK_Kbrf_WK_Dpq27pp_Z5d5rf_Y9_J7_C_240afc3a33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

