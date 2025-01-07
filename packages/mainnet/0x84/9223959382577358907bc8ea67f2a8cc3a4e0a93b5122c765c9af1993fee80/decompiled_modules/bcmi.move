module 0x849223959382577358907bc8ea67f2a8cc3a4e0a93b5122c765c9af1993fee80::bcmi {
    struct BCMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCMI>(arg0, 6, b"BCMI", b"Blue Chip Meme Index", b"Blue Chip Meme Coin Index", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BCMI_c704eee7a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

