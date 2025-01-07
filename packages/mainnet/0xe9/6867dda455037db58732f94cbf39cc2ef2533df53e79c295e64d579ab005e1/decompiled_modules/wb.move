module 0xe96867dda455037db58732f94cbf39cc2ef2533df53e79c295e64d579ab005e1::wb {
    struct WB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WB>(arg0, 6, b"WB", b"W BRIAN", x"436f2d666f756e64657220262043454f206174200a40436f696e626173650a2e204372656174696e67206d6f72652065636f6e6f6d69632066726565646f6d20696e2074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brian_494f9b51a9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WB>>(v1);
    }

    // decompiled from Move bytecode v6
}

