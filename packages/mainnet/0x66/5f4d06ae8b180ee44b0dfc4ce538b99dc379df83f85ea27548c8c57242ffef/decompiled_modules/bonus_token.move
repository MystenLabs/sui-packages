module 0x665f4d06ae8b180ee44b0dfc4ce538b99dc379df83f85ea27548c8c57242ffef::bonus_token {
    struct BONUS_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONUS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONUS_TOKEN>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONUS_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONUS_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

