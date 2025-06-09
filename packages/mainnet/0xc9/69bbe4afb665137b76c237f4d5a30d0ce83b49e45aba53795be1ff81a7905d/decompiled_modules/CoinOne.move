module 0xc969bbe4afb665137b76c237f4d5a30d0ce83b49e45aba53795be1ff81a7905d::CoinOne {
    struct COINONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINONE>(arg0, 9, b"C1", b"CoinOne", b"First coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a548ad67-5009-4def-9c45-2648a6920b5a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

