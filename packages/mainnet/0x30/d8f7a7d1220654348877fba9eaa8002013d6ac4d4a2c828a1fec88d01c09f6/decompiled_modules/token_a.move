module 0x30d8f7a7d1220654348877fba9eaa8002013d6ac4d4a2c828a1fec88d01c09f6::token_a {
    struct TOKEN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_A>(arg0, 9, b"TOKEN1", b"Token 1", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_A>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

