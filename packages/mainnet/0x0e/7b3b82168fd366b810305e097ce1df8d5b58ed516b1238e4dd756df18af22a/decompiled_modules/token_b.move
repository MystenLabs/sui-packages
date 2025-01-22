module 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::token_b {
    struct TOKEN_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_B>(arg0, 9, b"TOKEN2", b"Token 2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_B>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

