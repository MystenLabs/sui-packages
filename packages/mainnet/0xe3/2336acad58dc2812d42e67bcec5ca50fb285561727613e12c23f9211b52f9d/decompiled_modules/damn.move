module 0xe32336acad58dc2812d42e67bcec5ca50fb285561727613e12c23f9211b52f9d::damn {
    struct DAMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMN>(arg0, 6, b"DAMN", b"DICKMAN", b"Dickman is a newly introduced Superhero character in the Sui ecosystem. Despite having a unique appearance with an unusual head shape, Dickman is a superhero with a pure heart and is always ready to help anyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fire_e8f00027bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

