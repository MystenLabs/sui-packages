module 0xe80557d7f9b6cce827716c9f8ad1c6e34c95aae564847b223e0e163a64fd1317::token_a {
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

