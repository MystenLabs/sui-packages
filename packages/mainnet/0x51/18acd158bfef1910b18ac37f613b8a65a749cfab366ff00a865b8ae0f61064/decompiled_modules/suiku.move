module 0x5118acd158bfef1910b18ac37f613b8a65a749cfab366ff00a865b8ae0f61064::suiku {
    struct SUIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKU>(arg0, 6, b"SUIKU", b"SUIGOKU", b"WELCOME TO THE WORLD OF SUIGOKU ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kariminho9233_create_logo_songoku_en_bleue_v_6_1_446e0731_1e5b_4c88_a306_1b143631d76f_cc3d2c4993.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

