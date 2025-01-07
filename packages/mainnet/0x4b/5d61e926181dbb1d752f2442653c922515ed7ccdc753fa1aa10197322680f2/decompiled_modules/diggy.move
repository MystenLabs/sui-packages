module 0x4b5d61e926181dbb1d752f2442653c922515ed7ccdc753fa1aa10197322680f2::diggy {
    struct DIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGGY>(arg0, 6, b"DIGGY", b"TURBO DIGGY", b"Welcome to Diggy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955417268.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

