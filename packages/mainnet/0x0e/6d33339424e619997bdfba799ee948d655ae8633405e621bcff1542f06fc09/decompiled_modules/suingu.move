module 0xe6d33339424e619997bdfba799ee948d655ae8633405e621bcff1542f06fc09::suingu {
    struct SUINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGU>(arg0, 6, b"SUINGU", b"suingu", b"NHEK NHEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suingu_34ea681a70_5480a9e6ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

