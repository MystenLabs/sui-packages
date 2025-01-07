module 0x98eccf71852f3ebbbd9bc07debdcef9e80ed025be91472bb2c0652ab5694c8be::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"Corn", b"Corn HUB", b"Your Favourite Site To Visit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6731_93afe0426a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

