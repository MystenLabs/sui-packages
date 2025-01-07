module 0x10050969b0bfc5d30824cf4b453041fd012657c569890a000a5390cc6ee5fd3f::bax {
    struct BAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAX>(arg0, 6, b"BAX", b"Baby Axol", b"Baby Axol its a next meta on sui chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3537_26e0fe255b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

