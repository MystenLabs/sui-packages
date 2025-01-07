module 0x3b6175e7edd944f835c8bb782f63e0fbbaad3ec85b1fe6ad10e376d2fee556c9::s888 {
    struct S888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S888>(arg0, 6, b"S888", b"888 on Sui", b"An angel number with an unwavered mission to hit $888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016418_ffe38528d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S888>>(v1);
    }

    // decompiled from Move bytecode v6
}

