module 0xe9f386ffd3b61ad00f1cb987997f39b56b8d19b33b9ff58f54970b075dcc74a7::amd {
    struct AMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMD>(arg0, 6, b"AMD", b"Autistic Magic Dolphin", b"I think my dolphin has autism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5bngmmejw8v21_0cd890901d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

