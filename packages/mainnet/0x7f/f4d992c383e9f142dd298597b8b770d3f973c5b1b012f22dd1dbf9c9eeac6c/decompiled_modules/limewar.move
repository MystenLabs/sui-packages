module 0x7ff4d992c383e9f142dd298597b8b770d3f973c5b1b012f22dd1dbf9c9eeac6c::limewar {
    struct LIMEWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMEWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMEWAR>(arg0, 6, b"LIMEWAR", b"Sui Limewar", b"Welcome to limewar memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028660_a929f7143b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMEWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMEWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

