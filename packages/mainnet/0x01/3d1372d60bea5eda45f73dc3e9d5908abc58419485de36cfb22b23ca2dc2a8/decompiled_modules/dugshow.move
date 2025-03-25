module 0x13d1372d60bea5eda45f73dc3e9d5908abc58419485de36cfb22b23ca2dc2a8::dugshow {
    struct DUGSHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGSHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUGSHOW>(arg0, 6, b"DUGSHOW", b"DUG SHOW", x"4475672053686f77206a6f696e696e67205355492e205072657061726520666f72207468652073686f7720212057656620576566200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3f50d28b_18e3_4395_9dc9_2e9277eaccbf_e1f7e82330.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGSHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUGSHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

