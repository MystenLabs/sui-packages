module 0x9ec13b2c20e256897b6e418e1528f24f57a66f2173935a9c2d726c6a11888771::suicult {
    struct SUICULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICULT>(arg0, 6, b"SUICULT", b"SuicultOnSui", b"Suicult - the new meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000813_bf2020daa7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

