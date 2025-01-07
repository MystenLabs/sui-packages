module 0xb68c34abc5867d5e5bc5b89549f2789eb6d3a88dd8c470f7e5fb0d0f8a9f0069::shrimple {
    struct SHRIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPLE>(arg0, 6, b"SHRIMPLE", b"Make it SHRIMPLE", b"SHRIMP is here to make it \"SHRIMPLE\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pro_pic_11a381461b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

