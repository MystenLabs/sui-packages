module 0x946c3a358a7c8d0e7ba0ada8f34dddfd461aa6992ef198152715bfb5f326d9e6::why {
    struct WHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHY>(arg0, 6, b"Why", b"WHY WATTER", b"project for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741608073170.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

