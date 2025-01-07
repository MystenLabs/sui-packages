module 0x5ee9b898fe204973186dbdb39c97ab7ec6d2f62e082fe3e4a4237cc15b31bfa7::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"SNAKE KING", b"2025 Year of the Snake Price", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731766953461.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

