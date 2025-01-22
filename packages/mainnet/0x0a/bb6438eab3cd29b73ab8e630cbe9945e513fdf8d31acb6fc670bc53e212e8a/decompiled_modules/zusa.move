module 0xabb6438eab3cd29b73ab8e630cbe9945e513fdf8d31acb6fc670bc53e212e8a::zusa {
    struct ZUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUSA>(arg0, 4, b"ZUSA", b"Zustand test", b"Test ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ca1c3a00-d89c-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUSA>>(v1);
        0x2::coin::mint_and_transfer<ZUSA>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUSA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

