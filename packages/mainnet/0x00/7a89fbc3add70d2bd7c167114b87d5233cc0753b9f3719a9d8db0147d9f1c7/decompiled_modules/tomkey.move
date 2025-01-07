module 0x7a89fbc3add70d2bd7c167114b87d5233cc0753b9f3719a9d8db0147d9f1c7::tomkey {
    struct TOMKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMKEY>(arg0, 6, b"TOMKEY", b"Tomkey", b"Monkey see, monkey... become a tomato?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6f0abf241fb6b1f45a8472b3321ee6d5_e7e5b2d750.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

