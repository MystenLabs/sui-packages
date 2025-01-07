module 0x4c0161f0faaa775bc2cd2cbd50103a3ba2523b5bd6775e9a224d3885b1fa7509::book_of_sui_ {
    struct BOOK_OF_SUI_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOK_OF_SUI_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOK_OF_SUI_>(arg0, 9, b"Book Of Sui", b"BOS", b"Real Alpha. Gem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0X3_-CICzLvu9szHIFjHRB7nNSb42KBQWtA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOK_OF_SUI_>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOK_OF_SUI_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOK_OF_SUI_>>(v1);
    }

    // decompiled from Move bytecode v6
}

