module 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::token_c {
    struct TOKEN_C has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_C>(arg0, 9, b"TOKEN3", b"Token 3", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_C>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_C>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

