module 0x985a19f34c156de3b750f331c93412d1e2cc7fbdafaef6910bb9a3a8f52fb7cd::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 6, b"BS", b"Brosui", x"42726f2c206c657427732067617468657220616c6c207468652062726f20706f77657220696e2074686520776f726c6420616e6420626c617374206f666620746f206e6577206865696768747320776974682042726f7375692e20446f6e277420626520612062726f666167676f742c20626520612042726f7375692e0a4b69636b206261636b2c2072656c617820616e642062726f206f75742061732077652061696d20666f7220746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000476_7c1328c499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

