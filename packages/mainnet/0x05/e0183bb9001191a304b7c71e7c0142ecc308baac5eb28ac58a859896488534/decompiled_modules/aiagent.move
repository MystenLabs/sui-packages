module 0x5e0183bb9001191a304b7c71e7c0142ecc308baac5eb28ac58a859896488534::aiagent {
    struct AIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIAGENT>(arg0, 6, b"AIAGENT", b"AI Agent", x"4149204167656e7473206f6e2074686520537569204e6574776f726b2e200a48656c70206f75722070726f6a6563742067726f776e2e205669736974206f7572207369746520616e642074657374206f75722070726f647563740a546f6b656e20696e7472616672616374696f6e20636f6d696e6720736f6f6e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiaww_0c12e46e37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

