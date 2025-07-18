module 0x389780939096bbeaa59236918026fe03599a0a6f6686fe55ce76a3fe10349713::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"Troll", b"Trollngo", b"Just troll meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmiwt56hyl3gunfjapq4bozafb6pfj44hlk3d7jaj2nfpghd4uui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

