module 0xb47f3b9fa476f9ebe4b8cf679ead2c8a0f4abd92d49c0519f80a6da1234eded8::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"POOR", b"Poorlax", b"Still holding. Still hoping. Still poor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746226799440.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

