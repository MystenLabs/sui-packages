module 0xd2ffe485e9c84c67917103e4f2a5abe1ce63756da2d5a80df202003b2429120a::turclip {
    struct TURCLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURCLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURCLIP>(arg0, 6, b"Turclip", b"turboclip", b"TURCLIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949376346.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURCLIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURCLIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

