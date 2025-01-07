module 0x57be09e6497ebcba0da7764bcb72dddbf9bd9580801a5350f5b19b653bcb1a7f::blog {
    struct BLOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOG>(arg0, 6, b"Blog", b"Best loog", b"The Mars program has already begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013521_dba7c9ff13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

