module 0x20f1824ab0eb19fafe64fb5818d0fcac0ac088b9ef4b8508860d8ef12d5c80b2::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"MARS", b"Mars", b"to the mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731795174501.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

