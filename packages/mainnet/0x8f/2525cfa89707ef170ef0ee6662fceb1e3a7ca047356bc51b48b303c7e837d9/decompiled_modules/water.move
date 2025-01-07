module 0x8f2525cfa89707ef170ef0ee6662fceb1e3a7ca047356bc51b48b303c7e837d9::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Water on Sui", b"#Suis beloved mascot token! Dive into the refreshing world of $WATER, where gains flows!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_C1kp_W5b_400x400_1_18b81dbf12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

