module 0xaf966a7b30c365f2f0775a3ac6b9c13e4cce4905821fc60d6531aa69a2821535::token_b {
    struct TOKEN_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_B>(arg0, 9, b"TB", b"TokenB", b"Token B description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_B>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

