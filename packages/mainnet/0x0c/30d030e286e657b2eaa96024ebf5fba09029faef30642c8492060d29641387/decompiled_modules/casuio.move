module 0xc30d030e286e657b2eaa96024ebf5fba09029faef30642c8492060d29641387::casuio {
    struct CASUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUIO>(arg0, 6, b"Casuio", b"casuio", b"A well-known Japanese company \"Casio\" liked $sui so much that they decided to open here now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cas_5e148d7391.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

