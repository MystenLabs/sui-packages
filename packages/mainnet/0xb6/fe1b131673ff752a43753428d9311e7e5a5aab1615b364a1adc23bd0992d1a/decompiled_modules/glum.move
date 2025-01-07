module 0xb6fe1b131673ff752a43753428d9311e7e5a5aab1615b364a1adc23bd0992d1a::glum {
    struct GLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUM>(arg0, 6, b"GLUM", b"Glum", b"Driven by curiosity, Glum decided to leave his murky home for the first time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/glum_04893a86a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

