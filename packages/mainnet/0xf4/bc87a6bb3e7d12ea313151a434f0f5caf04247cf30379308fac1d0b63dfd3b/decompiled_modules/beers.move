module 0xf4bc87a6bb3e7d12ea313151a434f0f5caf04247cf30379308fac1d0b63dfd3b::beers {
    struct BEERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERS>(arg0, 6, b"BEERS", b"Sui Beer", b"First Beer in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000112998_be6c181d5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

