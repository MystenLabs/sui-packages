module 0x6c65e62b69db38934542bb9a07cd8ad178c5ce68b523bb5585ed771dc4e0f7c7::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 6, b"Smoke", b"smoked", b"Smoke For Healing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734260662961.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

