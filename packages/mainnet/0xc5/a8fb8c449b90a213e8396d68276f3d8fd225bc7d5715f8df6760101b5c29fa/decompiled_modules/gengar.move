module 0xc5a8fb8c449b90a213e8396d68276f3d8fd225bc7d5715f8df6760101b5c29fa::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 6, b"GENGAR", b"gengar", b"My favorite pokemon. He deserves more than what he got, that's why I'm here to take him to the millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_M3f9hjf_C_Yp5_G4_KKMF_8_Jkq_Tqnr_My_Lm_X_Tj19_Mi_X1k1_Wov_d28b6bf775.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

