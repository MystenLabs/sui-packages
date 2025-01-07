module 0xc01041cee6b83110f1d7fea92309291d054de75109eb91d883a9c6ab61e38f9::ollama {
    struct OLLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLLAMA>(arg0, 6, b"OLLAMA", b"BARACK OLLAMA", x"4865206e657665722066697420696e2077697468206869732066656c6c6f77732e20200a486520616c776179732066656c742061206c6974746c6520646966666572656e742e0a0a2e2e2e686520626567616e20636f6e74656d706c6174696e67207468652069646561206f662074616b696e67206f7665722074686520776f726c642e2e2e0a0a2e2e2e627574207768617420636f756c64206865206163636f6d706c6973682061732061206c6c616d6120776974686f757420612062697274682063657274696669636174653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ollama_dfe0638f68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

