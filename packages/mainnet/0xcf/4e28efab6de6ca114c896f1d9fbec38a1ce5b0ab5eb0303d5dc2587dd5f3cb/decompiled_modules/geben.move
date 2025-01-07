module 0xcf4e28efab6de6ca114c896f1d9fbec38a1ce5b0ab5eb0303d5dc2587dd5f3cb::geben {
    struct GEBEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEBEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEBEN>(arg0, 6, b"GEBEN", b"Geben coin", x"4772656574696e67732062726f746865727320616e6420736973746572732c200a5468697320697320746865206f726967696e616c20476162656e636f696e2c203130207965617273206c617465722061732061206d656d6520636f696e2c206275742077697468207468652073616d6520676f616c2e0a0a22496e206d79206e616d65206974207368616c6c20626520646f6e652e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_175933_936_a75859bbe0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEBEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEBEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

