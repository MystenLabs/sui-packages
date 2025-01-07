module 0x857b6e03abdfdd676b723743fe5f0bd333ef9231a733a0075f2d171acbd2994f::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"abc", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/memene.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

