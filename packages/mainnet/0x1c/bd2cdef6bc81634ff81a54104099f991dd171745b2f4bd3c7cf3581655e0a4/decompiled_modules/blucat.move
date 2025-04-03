module 0x1cbd2cdef6bc81634ff81a54104099f991dd171745b2f4bd3c7cf3581655e0a4::blucat {
    struct BLUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUCAT>(arg0, 6, b"BLUCAT", b"Blucat", b"Blue Cat ( $BLUCAT) - Coolest Cats memecoin on sui Community-driven, purr-fectly fun token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053470_e0e101dd78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

