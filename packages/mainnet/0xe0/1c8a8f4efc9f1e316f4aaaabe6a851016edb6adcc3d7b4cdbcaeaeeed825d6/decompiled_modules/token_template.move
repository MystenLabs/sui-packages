module 0xe01c8a8f4efc9f1e316f4aaaabe6a851016edb6adcc3d7b4cdbcaeaeeed825d6::token_template {
    struct TOKEN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_TEMPLATE>(arg0, 9, b"BT2137893", b"BatchToken2 137893", b"Second atomic deployment", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

