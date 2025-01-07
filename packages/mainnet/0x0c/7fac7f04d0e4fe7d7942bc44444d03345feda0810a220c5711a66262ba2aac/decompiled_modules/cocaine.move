module 0xc7fac7f04d0e4fe7d7942bc44444d03345feda0810a220c5711a66262ba2aac::cocaine {
    struct COCAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCAINE>(arg0, 6, b"COCAINE", b"COCAINE HORSE SUI", b"Just a depressed horse running around in this wild west of crypto, with his small pack of cocaine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5efc100b658fc4d6b03c53547578ea84_97253c3e46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCAINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCAINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

