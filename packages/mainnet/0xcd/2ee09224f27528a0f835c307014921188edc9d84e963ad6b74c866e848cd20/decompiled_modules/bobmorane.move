module 0xcd2ee09224f27528a0f835c307014921188edc9d84e963ad6b74c866e848cd20::bobmorane {
    struct BOBMORANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBMORANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBMORANE>(arg0, 6, b"Bobmorane", b"Bob morane", b"Bob Morane is an animated series 1998", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735928451432.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBMORANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBMORANE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

