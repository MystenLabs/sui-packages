module 0x914da1532a90a2fec28e33c110e45d0aeea8b29826caf25f5ca693b44e5dda26::daram {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 6, b"DARAM", b"Daram-CTO", b"100% fairness, anyone can only get tokens through free mint. Absolute dispersion. This is the most perfect meme coin ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/670937486fe782eefa2ae2d1_1728657225_672c7ebf90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

