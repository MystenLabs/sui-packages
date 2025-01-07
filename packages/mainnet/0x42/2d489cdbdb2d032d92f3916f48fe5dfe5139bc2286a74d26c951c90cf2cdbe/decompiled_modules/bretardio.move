module 0x422d489cdbdb2d032d92f3916f48fe5dfe5139bc2286a74d26c951c90cf2cdbe::bretardio {
    struct BRETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETARDIO>(arg0, 6, b"bRETARDIO", b"Baby Retardio", b"Baby version of Retardio. Community-based token on SUI Network. Don't be retard, HODL!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_23_08_00_11_4dcc060828.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

