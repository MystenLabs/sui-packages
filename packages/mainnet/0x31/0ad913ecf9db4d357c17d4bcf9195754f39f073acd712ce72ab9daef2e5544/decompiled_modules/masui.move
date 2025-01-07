module 0x310ad913ecf9db4d357c17d4bcf9195754f39f073acd712ce72ab9daef2e5544::masui {
    struct MASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASUI>(arg0, 6, b"MASUI", b"MASUI CAT", b"MASUI - is a magical cat with a gold medallion that brings good luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Firefly_blue_cat_anime_golden_medalion_white_background_26056_3f291e22b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

