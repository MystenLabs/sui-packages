module 0xdc939ed9833661d16b540d14c98234f902b0b3739b06aff2710d4319c8517061::fruits {
    struct FRUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUITS>(arg0, 6, b"Fruits", b"Fruits on Sui", b"NO HUMAN, NO ANIMAL, ONLY $FRUITS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731253196909.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRUITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

