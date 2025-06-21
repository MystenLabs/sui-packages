module 0x1c4d9d858b869f1cc58be2dfb99b89678ef2214b0faa55327e9f860f3381d069::t5 {
    struct T5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T5>(arg0, 6, b"T5", b"Test 5m", b"xx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreianiqo4fm6ugdnf2z6pizpxkjgfitpuvqp6wx4bln43t6njabxe6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T5>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

