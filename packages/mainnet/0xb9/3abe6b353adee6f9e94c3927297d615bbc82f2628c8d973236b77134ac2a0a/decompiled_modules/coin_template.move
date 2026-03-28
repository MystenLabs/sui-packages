module 0xb93abe6b353adee6f9e94c3927297d615bbc82f2628c8d973236b77134ac2a0a::coin_template {
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

