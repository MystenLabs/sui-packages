module 0x2b7b5950cea77bbc56f05fb57aa242bf1a4d9b2d687acd0ec079a6108280647a::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"abc", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABC>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

