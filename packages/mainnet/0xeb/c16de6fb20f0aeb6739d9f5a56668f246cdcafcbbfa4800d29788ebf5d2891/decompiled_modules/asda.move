module 0xebc16de6fb20f0aeb6739d9f5a56668f246cdcafcbbfa4800d29788ebf5d2891::asda {
    struct ASDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASDA>(arg0, 6, b"ASDA", b"asd by SuiAI", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Foto_b0f1e79f4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

