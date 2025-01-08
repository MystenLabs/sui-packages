module 0x9d84932c7e46290314fcd6194e47dc69546e848f09b86c0758e0c30c8615fa50::zozo {
    struct ZOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOZO>(arg0, 6, b"ZOZO", b"Zozo", b"$ZOZO FIRST SUI A.I. PUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022203_251e9c3ec5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

