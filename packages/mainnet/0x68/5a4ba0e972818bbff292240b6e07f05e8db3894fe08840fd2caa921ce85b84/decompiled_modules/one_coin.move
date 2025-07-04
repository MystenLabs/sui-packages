module 0x685a4ba0e972818bbff292240b6e07f05e8db3894fe08840fd2caa921ce85b84::one_coin {
    struct ONE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE_COIN>(arg0, 9, b"OC1", b"one coin", b"one coin desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8e98786f-ba18-45c1-b655-b85a66f179fe.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

