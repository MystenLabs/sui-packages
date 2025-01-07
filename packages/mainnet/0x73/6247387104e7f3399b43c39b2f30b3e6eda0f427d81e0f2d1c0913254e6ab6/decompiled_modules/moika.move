module 0x736247387104e7f3399b43c39b2f30b3e6eda0f427d81e0f2d1c0913254e6ab6::moika {
    struct MOIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOIKA>(arg0, 6, b"MOIKA", b"Sui Moika", b"MOIKA Moika is loved by everyone for his sweet nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017104_b56c1a8b1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

