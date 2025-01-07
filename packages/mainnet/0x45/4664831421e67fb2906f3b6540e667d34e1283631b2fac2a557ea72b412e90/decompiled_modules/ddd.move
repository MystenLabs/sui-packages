module 0x454664831421e67fb2906f3b6540e667d34e1283631b2fac2a557ea72b412e90::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"TTT", b"TT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_23_at_14_31_51_5225f6d9a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

