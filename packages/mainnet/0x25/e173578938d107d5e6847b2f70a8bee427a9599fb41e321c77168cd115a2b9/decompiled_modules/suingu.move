module 0x25e173578938d107d5e6847b2f70a8bee427a9599fb41e321c77168cd115a2b9::suingu {
    struct SUINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGU>(arg0, 6, b"SUINGU", b"suingu", b"NHEK NHEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suingu_34ea681a70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

