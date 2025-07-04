module 0xf7edcc4ca8b5b1305f62bd8ac446e911d8a701033f7ff22b79d8a24ae85a0c4::twor {
    struct TWOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWOR>(arg0, 6, b"TWOR", b"TOKENIZE WORLD", b"TOKENIZE WORLD TOKENIZE WORLD TOKENIZE WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidkyrglqnvbcya6v3cu6rhgyakepjz7w6gmkf25c4ghnx6auzi4rq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

