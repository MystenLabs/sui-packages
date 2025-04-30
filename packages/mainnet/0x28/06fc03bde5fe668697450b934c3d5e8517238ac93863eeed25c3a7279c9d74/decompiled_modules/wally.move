module 0x2806fc03bde5fe668697450b934c3d5e8517238ac93863eeed25c3a7279c9d74::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 6, b"WALLY", b"Wally", x"496e74726f647563696e67202457414c4c592e20496e73706972656420627920616e206f72616e67652077616c72757320696e206120686f6f6469652c204275696c7420666f722074686f73652077686f206c6f7665206172742c20636f6d6d756e6974792c20616e64206120746f756368206f662066756e2e204a6f696e20746865206d6f76656d656e7420616e642062652070617274206f6620736f6d657468696e6720637265617469766521200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wally_logo_7f8fe4bc78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

