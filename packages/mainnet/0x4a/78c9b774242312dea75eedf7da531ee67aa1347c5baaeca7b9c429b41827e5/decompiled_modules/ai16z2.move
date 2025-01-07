module 0x4a78c9b774242312dea75eedf7da531ee67aa1347c5baaeca7b9c429b41827e5::ai16z2 {
    struct AI16Z2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z2>(arg0, 6, b"AI16Z2", b"Ai16z2Agent", b"AI2 token from A16Z community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGJF77WYVMJ4GD82R955/01JC7Q2QZ8Z29V77QWJ7SNBJB2")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI16Z2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

