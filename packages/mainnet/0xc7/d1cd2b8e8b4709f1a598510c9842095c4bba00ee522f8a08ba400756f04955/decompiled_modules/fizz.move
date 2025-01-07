module 0xc7d1cd2b8e8b4709f1a598510c9842095c4bba00ee522f8a08ba400756f04955::fizz {
    struct FIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZZ>(arg0, 6, b"FIZZ", b"FIZZ on SUI", b"A species of fish that lives in deep waters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/toy_3820812_1280_b507d80660.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

