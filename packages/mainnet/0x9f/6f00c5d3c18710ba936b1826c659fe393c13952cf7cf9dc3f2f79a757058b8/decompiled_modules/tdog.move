module 0x9f6f00c5d3c18710ba936b1826c659fe393c13952cf7cf9dc3f2f79a757058b8::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"TDOG", b"Turbo DOG", b"Turbo Dog on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953744493.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

