module 0x77c6259635e43f24b5939cf726bfe99c0f58838b05ee09845b1a15155c5ab5b8::bomba {
    struct BOMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMBA>(arg0, 6, b"Bomba", b"BombaS", b"BombaBombaBomba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_5_e249c43d0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

