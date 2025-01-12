module 0x35ce80b5c962d93385230141677683feb4e05cea9d6b27b81f08592533a01d32::anima {
    struct ANIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIMA>(arg0, 6, b"ANIMA", b"Anima Labs AI", b"We are not physical chauvinists. We believe in a future as much situated in cyberspace as the physical world, a future that is open, boundless and interoperable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6176_775f353091.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

