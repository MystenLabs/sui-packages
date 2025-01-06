module 0xa04f6ebc13fbb16706b675fa4c94eb33994dd9e36eafa750851f2d9234eb5bda::razty {
    struct RAZTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAZTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAZTY>(arg0, 6, b"RAZTY", b"Razty Rooster", b"RAZTY Will be champion in the sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021177_948ef441c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAZTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAZTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

