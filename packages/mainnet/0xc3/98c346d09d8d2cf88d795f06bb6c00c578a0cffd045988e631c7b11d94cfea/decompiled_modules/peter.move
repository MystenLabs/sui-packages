module 0xc398c346d09d8d2cf88d795f06bb6c00c578a0cffd045988e631c7b11d94cfea::peter {
    struct PETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETER>(arg0, 6, b"Peter", b"Peter the suisploer", b"I find stuff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bird_nft_rare_1_8587f5cae9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

