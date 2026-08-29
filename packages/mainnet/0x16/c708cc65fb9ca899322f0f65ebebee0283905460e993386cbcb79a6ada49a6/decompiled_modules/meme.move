module 0x16c708cc65fb9ca899322f0f65ebebee0283905460e993386cbcb79a6ada49a6::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"MEME", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/de3a81e2ecb5642d9334813515acc141713df32dfc4812a7cf8bd9f0b246db91.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

