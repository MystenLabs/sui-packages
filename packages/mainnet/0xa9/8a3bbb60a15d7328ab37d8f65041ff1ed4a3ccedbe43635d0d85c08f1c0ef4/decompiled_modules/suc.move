module 0xa98a3bbb60a15d7328ab37d8f65041ff1ed4a3ccedbe43635d0d85c08f1c0ef4::suc {
    struct SUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUC>(arg0, 6, b"SUC", b"Suience", b"sui's first science token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/350736bd_b01a_48ee_9628_86abbca1fc17_c1d83a1f78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

