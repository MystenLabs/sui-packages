module 0xe6e8076123c7f17b63dde5c93ed1dd58d9c1bc14a15b2f5cbf58c171fff5ac5::goodbunny {
    struct GOODBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODBUNNY>(arg0, 6, b"Goodbunny", b"The one and only good bunny on sui", b"When the catch is near, use the bunnies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_214631_325_59a8cc46f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOODBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

