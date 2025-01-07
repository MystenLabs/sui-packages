module 0x7c1f01a9df8d45ca1e84efb88e3953dbf534a418cff5cfd64eefeeebab9b6a4c::ats {
    struct ATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATS>(arg0, 6, b"ATS", b"Atsuko Sato", b"I am a full-time childcare worker who dreams of a life where I can take naps with my four cats every day. I will be introducing the cute, funny, warm and heartwarming daily lives of Kabosu, Tsutsuji, Ginnan and Onigiri.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_17_58_22_10baf1c04a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

