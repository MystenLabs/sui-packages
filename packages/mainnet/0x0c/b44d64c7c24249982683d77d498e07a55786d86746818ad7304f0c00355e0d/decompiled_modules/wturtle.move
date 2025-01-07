module 0xcb44d64c7c24249982683d77d498e07a55786d86746818ad7304f0c00355e0d::wturtle {
    struct WTURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTURTLE>(arg0, 6, b"wTURTLE", b"Wrapped Turtle", b"it's a wrapped turtle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_03_32_26_1e42cc9c0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

