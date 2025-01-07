module 0x35adf6a0be64838ae1604276e740798d52005cce83430e80ec88782719cbc7fe::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"SANDY", b"An experiment, can squirrels survive under water?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734114262477.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

