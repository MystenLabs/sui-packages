module 0xfde6dcc8c6121da5399d1c712e8fd7247d1ab847fd9d1b2c3256fbc80e115b28::t3 {
    struct T3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T3>(arg0, 6, b"T3", b"t1", b"t3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_bad0ecc3c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T3>>(v1);
    }

    // decompiled from Move bytecode v6
}

