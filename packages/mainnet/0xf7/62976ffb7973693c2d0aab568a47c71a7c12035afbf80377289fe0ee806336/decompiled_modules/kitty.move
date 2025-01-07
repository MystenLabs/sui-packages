module 0xf762976ffb7973693c2d0aab568a47c71a7c12035afbf80377289fe0ee806336::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"KITTY", b"Kitty", b"The cutest Kitty on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731126783231.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

