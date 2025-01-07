module 0x8bafa18829033a61fe719869d7f94d858c1d8268bb0fab13363ff8c2b1399842::dogpool {
    struct DOGPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPOOL>(arg0, 6, b"DOGPOOL", b"DogPool", b"Dogpool Coin is a revolutionary cryptocurrency that converges meme culture and blockchain technology. Our mission is to create a rewarding and unpredictable crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_07e6c5e352.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

