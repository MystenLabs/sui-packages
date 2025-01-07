module 0xc30dc2e28c1426deb1e53a7d16d32cdf62a8f3dc5e87cc6e4967e92a1cec2ab6::lewis {
    struct LEWIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEWIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEWIS>(arg0, 6, b"LEWIS", b"LEWIS ON SUI", b"QUACK QUACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lewis_a59e53e11c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEWIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEWIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

