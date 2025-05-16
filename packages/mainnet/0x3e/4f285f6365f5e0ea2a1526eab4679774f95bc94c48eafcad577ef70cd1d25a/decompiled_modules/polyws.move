module 0x3e4f285f6365f5e0ea2a1526eab4679774f95bc94c48eafcad577ef70cd1d25a::polyws {
    struct POLYWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLYWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLYWS>(arg0, 6, b"POLYWS", b"PolyW on Sui", b"\"POLYWSUI  High Jump, Spiral Profits!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_16_21_23_35_4b6159f8a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLYWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLYWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

