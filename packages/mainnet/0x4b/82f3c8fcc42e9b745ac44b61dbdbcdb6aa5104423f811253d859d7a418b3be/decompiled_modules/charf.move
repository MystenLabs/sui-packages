module 0x4b82f3c8fcc42e9b745ac44b61dbdbcdb6aa5104423f811253d859d7a418b3be::charf {
    struct CHARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARF>(arg0, 6, b"CHARF", b"Chad Dog", b"Chad Dog is a meme-based crypto token (CHARF) that blends the swagger of Chad culture with playful dominance of the Shiba Inu meme. Alpha dog of the meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731469069191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

