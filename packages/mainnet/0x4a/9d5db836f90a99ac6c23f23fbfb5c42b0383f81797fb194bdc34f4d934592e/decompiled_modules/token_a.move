module 0x4a9d5db836f90a99ac6c23f23fbfb5c42b0383f81797fb194bdc34f4d934592e::token_a {
    struct TOKEN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_A>(arg0, 9, b"TA", b"TokenA", b"Token A description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_A>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

