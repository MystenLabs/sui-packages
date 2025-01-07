module 0xe36361b8956943aebcee8901dd37c7cb709e993aa142e250611c7675f21e41c7::cake {
    struct CAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 6, b"Cake", b"Sui cake", b"Sui Cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cake_6950450c27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

