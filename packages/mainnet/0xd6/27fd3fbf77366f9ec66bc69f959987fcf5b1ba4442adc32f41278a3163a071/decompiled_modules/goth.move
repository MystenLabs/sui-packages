module 0xd627fd3fbf77366f9ec66bc69f959987fcf5b1ba4442adc32f41278a3163a071::goth {
    struct GOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTH>(arg0, 6, b"GOTH", b"Goth", b"Have you thought to yourself: \">TFW no goth gf\"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X_Et_Fo1zmwn_M6s_Wipr_Lmww2v_ZXD_5_Acsqw_Mz_Wi_U6v_D4_Fb_02a6c549c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

