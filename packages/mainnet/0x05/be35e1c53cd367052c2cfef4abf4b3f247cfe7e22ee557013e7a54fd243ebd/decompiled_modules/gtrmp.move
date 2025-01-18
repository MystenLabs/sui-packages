module 0x5be35e1c53cd367052c2cfef4abf4b3f247cfe7e22ee557013e7a54fd243ebd::gtrmp {
    struct GTRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTRMP>(arg0, 6, b"GTRMP", b"Goku Trump", b"GET YOUR $TRUMP NOW. Go to gettrumpmemes.com  Have Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026981_9fc0d78f91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

