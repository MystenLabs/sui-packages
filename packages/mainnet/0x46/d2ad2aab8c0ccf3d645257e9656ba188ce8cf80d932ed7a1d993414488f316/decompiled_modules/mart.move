module 0x46d2ad2aab8c0ccf3d645257e9656ba188ce8cf80d932ed7a1d993414488f316::mart {
    struct MART has drop {
        dummy_field: bool,
    }

    fun init(arg0: MART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MART>(arg0, 6, b"Mart", b"Gumart", b"Build the ultimate market place on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022420_a83fd569e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MART>>(v1);
    }

    // decompiled from Move bytecode v6
}

