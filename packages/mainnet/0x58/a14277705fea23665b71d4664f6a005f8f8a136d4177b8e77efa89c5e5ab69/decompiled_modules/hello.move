module 0x58a14277705fea23665b71d4664f6a005f8f8a136d4177b8e77efa89c5e5ab69::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 9, b"hello", b"hello", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

