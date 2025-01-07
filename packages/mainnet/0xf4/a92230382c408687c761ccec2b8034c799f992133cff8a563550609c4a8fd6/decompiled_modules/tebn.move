module 0xf4a92230382c408687c761ccec2b8034c799f992133cff8a563550609c4a8fd6::tebn {
    struct TEBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEBN>(arg0, 6, b"TEBN", b"The Teddy Bean", x"546865204f726967696e616c204d722e204265616ee2809973204661766f72697465205465646479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732563364607.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEBN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEBN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

