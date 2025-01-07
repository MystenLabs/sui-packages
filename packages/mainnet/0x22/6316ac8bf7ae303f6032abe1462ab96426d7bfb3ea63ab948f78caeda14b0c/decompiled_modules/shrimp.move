module 0x226316ac8bf7ae303f6032abe1462ab96426d7bfb3ea63ab948f78caeda14b0c::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 6, b"Shrimp", b"Shrimp to feed all whales on Sui", b"This shrimp will feed all the whales on Sui and quench their hunger!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrimp_0ab96a478f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

