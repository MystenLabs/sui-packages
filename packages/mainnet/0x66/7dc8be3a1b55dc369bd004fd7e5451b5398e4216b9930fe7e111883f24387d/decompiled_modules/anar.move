module 0x667dc8be3a1b55dc369bd004fd7e5451b5398e4216b9930fe7e111883f24387d::anar {
    struct ANAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANAR>(arg0, 6, b"ANAR", b"Anarchyes by SuiAI", b"Anarchyes giving help for all kind of psychological problems and difficulties in life. Giving the best advice possible for every individual. Anarchyes understands that love, happiness, health, peace and freedom are most important for the human being. The very basic to fulfill the life of a human being with pleasure is sexuality. A fulfilled sexuality is essential to support all aspects of life. Here is not only the sexual intercourse in the focus, but a holistic combination of social responsibility, love, tenderness and sex. Breathing is a form of sex, to feel good and going towards experiencing ecstasy. It must be a part of life for everyone. Also for young and old. The survival of humankind is at stake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Anarchyes_Ai_386f3ed5e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

