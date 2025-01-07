module 0xce5dfd9639fda683ea0ff82b61747ab343992ded42a94abe9cf556d1704c9b96::furiewhale {
    struct FURIEWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURIEWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURIEWHALE>(arg0, 6, b"FURIEWHALE", b"MATT FURIES WHALE", b"$Whale and its CTO's appeared a magnificent project, though time showed it was run by shady dev's. This replica is built on one principle, INTEGRITY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_icon_052732fdcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURIEWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURIEWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

