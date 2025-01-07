module 0xbc70138d7a7ca8f67170101e095660f0e7a226da9a87e1d85496801556441d8::btcp {
    struct BTCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCP>(arg0, 6, b"BTCP", b"Bitcoin Pizza", b"A BTC or a PIZZA?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_142_6b12bb40cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

