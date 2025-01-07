module 0x7af8b6c956879ee6cf06265a1d60682cb5528c96316b0c43f5309f08d849c4d4::mart {
    struct MART has drop {
        dummy_field: bool,
    }

    fun init(arg0: MART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MART>(arg0, 6, b"Mart", b"Gumart", b"Build ultimate market place on sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022420_e4276af022.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MART>>(v1);
    }

    // decompiled from Move bytecode v6
}

