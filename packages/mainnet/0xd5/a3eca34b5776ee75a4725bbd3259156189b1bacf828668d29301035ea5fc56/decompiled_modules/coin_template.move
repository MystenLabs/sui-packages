module 0xd5a3eca34b5776ee75a4725bbd3259156189b1bacf828668d29301035ea5fc56::coin_template {
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

