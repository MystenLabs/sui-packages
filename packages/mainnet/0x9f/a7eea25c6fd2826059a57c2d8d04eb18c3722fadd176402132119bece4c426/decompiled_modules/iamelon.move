module 0x9fa7eea25c6fd2826059a57c2d8d04eb18c3722fadd176402132119bece4c426::iamelon {
    struct IAMELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMELON>(arg0, 6, b"IAMELON", b"I am Elon", b"I am actually Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732439772203.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IAMELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

