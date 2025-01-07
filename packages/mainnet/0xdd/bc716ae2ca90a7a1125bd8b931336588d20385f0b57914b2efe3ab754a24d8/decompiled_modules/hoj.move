module 0xddbc716ae2ca90a7a1125bd8b931336588d20385f0b57914b2efe3ab754a24d8::hoj {
    struct HOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOJ>(arg0, 6, b"HOJ", b"HAMMER OF JUSTICE", b"The Hammer of Justice is Coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731541041346.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

