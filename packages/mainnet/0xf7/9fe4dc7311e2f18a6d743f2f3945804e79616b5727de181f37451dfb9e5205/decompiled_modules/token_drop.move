module 0xf79fe4dc7311e2f18a6d743f2f3945804e79616b5727de181f37451dfb9e5205::token_drop {
    struct TOKEN_DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_DROP>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_DROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

