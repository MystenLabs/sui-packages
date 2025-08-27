module 0x7ecc000c2180cb78e392c9b03d3fc500be2e5abe8cb34c28b749afb3bda07349::Trolly {
    struct TROLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLY>(arg0, 9, b"LOLTROL", b"Trolly", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GyuW0bIXwAArW3c?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

