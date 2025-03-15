module 0xc2e11b0bbc8eeadfa3439ecf02ac1f2c598fbab5422e77f460b1ca1651082a78::suiseal {
    struct SUISEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEAL>(arg0, 6, b"SuiSeal", b"Mr.SuiSeal", b"Just cool seal born in trenches on his mission to became unforgettable with unique handmade art and sense of humor. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2288_3de64139d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

