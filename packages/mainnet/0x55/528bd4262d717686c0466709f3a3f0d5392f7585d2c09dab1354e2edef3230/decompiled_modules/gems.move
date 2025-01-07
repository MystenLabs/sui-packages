module 0x55528bd4262d717686c0466709f3a3f0d5392f7585d2c09dab1354e2edef3230::gems {
    struct GEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS>(arg0, 6, b"GEMS", b"Rick", b"Come build an grow us .. just a bunch of degenerates Finding some of the best plays out there.. everything we post is not FA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1529_42068b2b73.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

