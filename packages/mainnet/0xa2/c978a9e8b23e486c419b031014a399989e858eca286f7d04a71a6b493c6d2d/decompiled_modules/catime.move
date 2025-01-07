module 0xa2c978a9e8b23e486c419b031014a399989e858eca286f7d04a71a6b493c6d2d::catime {
    struct CATIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIME>(arg0, 6, b"CATIME", b"CATIME SUI", x"4361742054696d652054726176656c2066726f6d20323036392e2049276d206865726520776974682061206d697373696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t50aj_O12_400x400_1f17a41e83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

