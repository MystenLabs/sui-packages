module 0xc5c7d840b7680dd7426220c8cfacdc35971ac22a0e56de742f4920c40bbb10d8::coin_eight {
    struct COIN_EIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_EIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_EIGHT>(arg0, 9, b"coineight", b"coin eight", b"coin eight desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/d6a15e5b-aed5-4326-a187-ec859567bd62.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_EIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_EIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

