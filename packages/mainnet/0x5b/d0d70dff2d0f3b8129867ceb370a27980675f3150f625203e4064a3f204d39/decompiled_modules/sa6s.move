module 0x5bd0d70dff2d0f3b8129867ceb370a27980675f3150f625203e4064a3f204d39::sa6s {
    struct SA6S has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA6S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA6S>(arg0, 6, b"SA6S", b"SONIC AI 6900 SUI", x"536f6e696320746865204865646765686f67200a68747470733a2f2f742e6d652f736f6e69636169706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241231_035733_101_a739eea9ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA6S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SA6S>>(v1);
    }

    // decompiled from Move bytecode v6
}

