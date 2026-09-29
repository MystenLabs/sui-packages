module 0xbc644d7068c455378c7a0a86de958292c1057f53981c17447ac116f22e6ca214::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 9, b"papa", b"papa", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAPA>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

