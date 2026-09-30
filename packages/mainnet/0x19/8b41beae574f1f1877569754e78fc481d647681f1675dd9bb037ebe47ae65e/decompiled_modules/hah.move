module 0x198b41beae574f1f1877569754e78fc481d647681f1675dd9bb037ebe47ae65e::hah {
    struct HAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAH>(arg0, 9, b"hah", b"hah", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAH>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAH>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

