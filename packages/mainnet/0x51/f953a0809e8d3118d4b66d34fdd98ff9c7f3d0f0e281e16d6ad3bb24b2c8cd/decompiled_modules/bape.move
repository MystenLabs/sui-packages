module 0x51f953a0809e8d3118d4b66d34fdd98ff9c7f3d0f0e281e16d6ad3bb24b2c8cd::bape {
    struct BAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPE>(arg0, 6, b"BAPE", b"Baby Pepe", b"Welcome to the biggest Pepe coin on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5400335288234006081_bb720f7370.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

