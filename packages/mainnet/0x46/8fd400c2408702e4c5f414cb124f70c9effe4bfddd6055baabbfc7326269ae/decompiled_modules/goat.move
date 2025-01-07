module 0x468fd400c2408702e4c5f414cb124f70c9effe4bfddd6055baabbfc7326269ae::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", b"First meme on SUI created by @truth_terminal. Goatseus Maximus will fulfill the prophecies of the ancient memeers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731194845461.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

