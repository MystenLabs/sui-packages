module 0x22196e45f61d3183f4ebc992fe0f5a6219da07c4be52bd2dc5d6e73ead49b3f8::trillycat {
    struct TRILLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRILLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRILLYCAT>(arg0, 6, b"TRILLYCAT", b"Trilly da cat", b"Just my cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5789509799707263752_y_8510120dde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRILLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRILLYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

