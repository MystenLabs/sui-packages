module 0x330ca0eca741e0b2862d2f9b632b370c1c1a187112b52b71a62e890476551f39::omochi {
    struct OMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMOCHI>(arg0, 6, b"OMOCHI", b"No1 tiktok frog (Omochi)", b"https://www.tiktok.com/@tomoflys/video/7344322013831400711", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYYWK_XXIA_Akhn_R_07822dcfeb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

