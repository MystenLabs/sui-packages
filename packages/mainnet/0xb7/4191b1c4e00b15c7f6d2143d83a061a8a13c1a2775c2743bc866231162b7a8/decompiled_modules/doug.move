module 0xb74191b1c4e00b15c7f6d2143d83a061a8a13c1a2775c2743bc866231162b7a8::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"Doug", b"Doug The Pug", x"4b494e47204f4620504f502043554c545552452c20466f756e646572206f662040445450666f756e646174696f6e0a32782050656f706c65732043686f6963652041776172642057696e6e657220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_17_16_17_ca3b00697d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

