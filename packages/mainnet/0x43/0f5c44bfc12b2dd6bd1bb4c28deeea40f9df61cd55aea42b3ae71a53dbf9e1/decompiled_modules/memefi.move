module 0x430f5c44bfc12b2dd6bd1bb4c28deeea40f9df61cd55aea42b3ae71a53dbf9e1::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 6, b"MEMEFI", b"MEME FI", b"Sui Meme Fi at your service", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEMEF_a2e9a60c3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

