module 0x33c45a98a97cae28a6fef824c52f6c9cf772ea202f7f6c4589345129fa3d7f39::dr {
    struct DR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR>(arg0, 6, b"DR", b"Dogerise ", b"Doge Rise our dog that will take you to the moon our flying pet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731459283389.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

