module 0xae45d1c8a01e9d62c0d7c971618b7bbcdecd3739dc6495c1d9fd8c78d71e32b5::childoge {
    struct CHILDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILDOGE>(arg0, 6, b"CHILDOGE", b"CHILLDOGE", b"DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_01_39_03_17fe351d16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

