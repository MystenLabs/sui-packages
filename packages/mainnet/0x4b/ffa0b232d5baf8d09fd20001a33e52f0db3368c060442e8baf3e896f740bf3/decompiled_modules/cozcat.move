module 0x4bffa0b232d5baf8d09fd20001a33e52f0db3368c060442e8baf3e896f740bf3::cozcat {
    struct COZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZCAT>(arg0, 6, b"COZCAT", b"COZCAT SUI", b"to topple his rival, $COZCAT, and seize dominance in the meme coin arena.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cozcat_6914549948.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

