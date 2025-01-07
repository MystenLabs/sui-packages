module 0x841820b9ad11ce21ed23e1df28b101a12943463cdbe717bbd6d9c16ed28eb3a3::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", x"546865206f6e6c792058206f6620474f4154532e205265616c2024474f415453206e6576657220646965202e20426161612d6c6965766520746865206879706520200a20436c61696d2024474f4154533a2068747470733a2f2f742e6d652f7265616c676f6174735f626f74200a204368616e6e656c3a2068747470733a2f2f742e6d652f7265616c676f6174735f6368616e6e656c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728817250138_3d5de93521.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

