module 0x3f2c4f2194f45ba2c25b6a8a1a239c4633c12c6fb72169f61b8f1834c4b1e74e::two0 {
    struct TWO0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO0>(arg0, 6, b"TWO0", b"02", b"two0onetwo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Azzok_aaf290c355.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWO0>>(v1);
    }

    // decompiled from Move bytecode v6
}

