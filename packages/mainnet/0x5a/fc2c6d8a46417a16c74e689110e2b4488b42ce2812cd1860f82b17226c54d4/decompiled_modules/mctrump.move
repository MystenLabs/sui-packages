module 0x5afc2c6d8a46417a16c74e689110e2b4488b42ce2812cd1860f82b17226c54d4::mctrump {
    struct MCTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTRUMP>(arg0, 6, b"MCTRUMP", b"Mc Sui Trump", b"Trump Started Work On MC Donalds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9151_af87305b2a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

