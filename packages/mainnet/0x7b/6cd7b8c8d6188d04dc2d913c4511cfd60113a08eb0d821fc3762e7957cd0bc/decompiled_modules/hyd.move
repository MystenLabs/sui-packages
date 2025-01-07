module 0x7b6cd7b8c8d6188d04dc2d913c4511cfd60113a08eb0d821fc3762e7957cd0bc::hyd {
    struct HYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYD>(arg0, 6, b"HYD", b"How is your day?", b"How's everyone doing today? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732476826198.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

