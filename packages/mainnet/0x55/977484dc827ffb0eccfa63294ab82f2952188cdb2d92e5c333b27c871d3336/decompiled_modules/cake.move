module 0x55977484dc827ffb0eccfa63294ab82f2952188cdb2d92e5c333b27c871d3336::cake {
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

