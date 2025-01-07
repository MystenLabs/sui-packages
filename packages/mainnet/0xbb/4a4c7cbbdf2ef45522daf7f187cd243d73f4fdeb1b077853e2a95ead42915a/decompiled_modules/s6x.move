module 0xbb4a4c7cbbdf2ef45522daf7f187cd243d73f4fdeb1b077853e2a95ead42915a::s6x {
    struct S6X has drop {
        dummy_field: bool,
    }

    fun init(arg0: S6X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S6X>(arg0, 6, b"S6X", b"666", b"666 verses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993996405.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S6X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S6X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

