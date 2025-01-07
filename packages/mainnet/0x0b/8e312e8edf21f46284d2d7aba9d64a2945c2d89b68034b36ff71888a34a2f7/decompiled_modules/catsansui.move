module 0xb8e312e8edf21f46284d2d7aba9d64a2945c2d89b68034b36ff71888a34a2f7::catsansui {
    struct CATSANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSANSUI>(arg0, 6, b"CATSANSUI", b"CatSunSui", b"CAT SUN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_29_at_17_04_17_3685c62177.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

