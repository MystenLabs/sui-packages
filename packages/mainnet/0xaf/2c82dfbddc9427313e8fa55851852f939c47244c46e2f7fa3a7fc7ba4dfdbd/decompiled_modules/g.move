module 0xaf2c82dfbddc9427313e8fa55851852f939c47244c46e2f7fa3a7fc7ba4dfdbd::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 6, b"G", b"GG", b"We are G - MOVE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012336_c20ddbb74e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G>>(v1);
    }

    // decompiled from Move bytecode v6
}

