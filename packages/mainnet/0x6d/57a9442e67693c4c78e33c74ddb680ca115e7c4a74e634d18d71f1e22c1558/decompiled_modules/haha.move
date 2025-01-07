module 0x6d57a9442e67693c4c78e33c74ddb680ca115e7c4a74e634d18d71f1e22c1558::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 6, b"Haha", b"asd", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/homeblackpng_6ed6e6a351.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

