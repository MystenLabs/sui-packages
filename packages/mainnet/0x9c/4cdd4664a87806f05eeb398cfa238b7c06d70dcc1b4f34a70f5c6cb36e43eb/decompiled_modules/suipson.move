module 0x9c4cdd4664a87806f05eeb398cfa238b7c06d70dcc1b4f34a70f5c6cb36e43eb::suipson {
    struct SUIPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPSON>(arg0, 6, b"SUIPSON", b"Suipson Sui", b"$SUIPSON a meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000444_5a876b2c2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

