module 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::coin_template {
    struct COIN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_TEMPLATE>(arg0, 0, b"TEMPLATE", b"Wave Template Token", b"Launched on Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

