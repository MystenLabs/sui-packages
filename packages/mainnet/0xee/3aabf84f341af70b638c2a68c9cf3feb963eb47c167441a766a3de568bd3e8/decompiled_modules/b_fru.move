module 0xee3aabf84f341af70b638c2a68c9cf3feb963eb47c167441a766a3de568bd3e8::b_fru {
    struct B_FRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FRU>(arg0, 9, b"bFRU", b"bToken FRU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

