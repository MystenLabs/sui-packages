module 0xb98f5ed18beb6289b18be253e9f10ff0c39a0ce84ae725bc30accd1800f98236::coin_template {
    struct COIN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_TEMPLATE>(arg0, 6, b"Token", b"Token Name", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN_TEMPLATE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

