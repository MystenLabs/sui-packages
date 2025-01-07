module 0x1bad85ee677902958f2064a686e4aa85bd50cbf1e70a61716df05d3e56981057::rege {
    struct REGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGE>(arg0, 6, b"REGE", b"ZEfz", b"fze", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2178374_w1400h1400c1cx700cy350cxt0cyt0cxb1400cyb700_f90d82c223.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

