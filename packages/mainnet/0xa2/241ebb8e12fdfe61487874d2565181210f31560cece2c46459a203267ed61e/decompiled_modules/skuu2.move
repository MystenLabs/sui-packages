module 0xa2241ebb8e12fdfe61487874d2565181210f31560cece2c46459a203267ed61e::skuu2 {
    struct SKUU2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUU2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUU2>(arg0, 6, b"Skuu2", b"sadasd", b"daddasdeasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971306175.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKUU2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUU2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

