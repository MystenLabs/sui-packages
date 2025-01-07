module 0x94121e26f3c3a487c2c8daea86dd2d3d791f78aa006b26bf81fbc09b48bd59::tw {
    struct TW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TW>(arg0, 6, b"TW", b"Teenage Mutant Ninja Turtles", b"lit. the divine turtle leaves the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pirate_turtle_8748974_1280_6ceb791b94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TW>>(v1);
    }

    // decompiled from Move bytecode v6
}

