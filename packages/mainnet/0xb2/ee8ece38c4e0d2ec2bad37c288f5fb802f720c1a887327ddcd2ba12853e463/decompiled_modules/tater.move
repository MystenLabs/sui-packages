module 0xb2ee8ece38c4e0d2ec2bad37c288f5fb802f720c1a887327ddcd2ba12853e463::tater {
    struct TATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATER>(arg0, 6, b"TATER", b"Taterminal", x"45766572796f6e65206c6f7665732054415445522e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Q_Wd_BYA_Lm5_Wiw_K6mhe_XYEZX_Rf_W_Zfu_Rqb_Rg_F31_Px_EE_7n_Z_dc60922c9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

