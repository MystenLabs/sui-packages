module 0xa4fc2f85735bc1305eae6fd1126ef2309a8a09f6ab0d55584e41e4821dcef9b8::golduck {
    struct GOLDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDUCK>(arg0, 6, b"Golduck", b"Return Of The Quack", x"736f6d657468696e6720737472616e67652068617070656e65642e206c696b6520476f6c640a436f6d6d75697479203a200a68747470733a2f2f782e636f6d2f692f636f6d6d756e69746965732f31393436383537303734393932303334303133", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5zzsjv75w3y3vyxusl5njnsmldp77r7ce4oyhapj6pucus37hvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOLDUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

