module 0x127f756ae40425b63e8e4c928c9fe31ca8dfb8dd099bd5402b5969c66fb8c446::mart {
    struct MART has drop {
        dummy_field: bool,
    }

    fun init(arg0: MART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MART>(arg0, 6, b"Mart", b"Gumart", b"Build ultimate market place on sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022420_70a226a6e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MART>>(v1);
    }

    // decompiled from Move bytecode v6
}

