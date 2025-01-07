module 0xc9573ec8e84f6be8e7ace96bf4fe569c987585f9f9203445e3bc23877840089a::catermelon {
    struct CATERMELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATERMELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATERMELON>(arg0, 6, b"CATERMELON", b"CATER MELON", b"no web, no tg, just the catermelon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7839_28ef78073c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATERMELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATERMELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

