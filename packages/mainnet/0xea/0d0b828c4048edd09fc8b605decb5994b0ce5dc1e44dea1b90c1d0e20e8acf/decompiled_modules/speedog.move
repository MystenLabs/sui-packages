module 0xea0d0b828c4048edd09fc8b605decb5994b0ce5dc1e44dea1b90c1d0e20e8acf::speedog {
    struct SPEEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDOG>(arg0, 6, b"SPEEDOG", b"SPEED DOG", b"THE FASTEST DOG ON SUI NETWORK !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731063508628.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEEDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

