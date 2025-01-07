module 0x8d2e99d3eeb56a685d2cc9abb948b783f5f820729c79c96e36388196436d834::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 6, b"KABOSU", b"SUI KABOSU", b"Welcome to Kabosu! The cryptocurrency celebrating the illustrious life and legacy of Kabosu, the Shiba Inu who adorned the original Dogecoin and earned the title \"The Queen of Memecoins.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000075268_717bbda402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

