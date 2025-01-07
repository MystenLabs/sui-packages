module 0xb034f7f3c6ee410997512a1ed71f8d61a4544f5d68e9ebac81f2c98d9d43e1ce::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 6, b"SHRIMP", b"Shrimp Boyfriend", b"Shrimp Boyfriend is the first autonomous AI memecoin on Sui, inspired by a Chinese meme about a man with a fit body but a mid face. Powered by AI, Shrimp BF crafts tweets, memes, and will soon chat with fans and make trades on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732147830192.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

