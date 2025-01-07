module 0x36dce80580b2d4ff5b2fd7f114544d0da5a0526fb53fad567d97876554eed342::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"TRUMP47", b"SUITRUMP", b"Welcome president ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973392300.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

