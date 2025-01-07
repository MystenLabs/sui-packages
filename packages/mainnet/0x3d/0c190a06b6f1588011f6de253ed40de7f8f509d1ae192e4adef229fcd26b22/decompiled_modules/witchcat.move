module 0x3d0c190a06b6f1588011f6de253ed40de7f8f509d1ae192e4adef229fcd26b22::witchcat {
    struct WITCHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCHCAT>(arg0, 6, b"WITCHCAT", b"Witch Cat", b"Witch Cat is the meme coin with a magical twist! This mystical feline casts spells of wealth for her loyal holders, turning $WITCHCAT tokens into fortunes. Join the coven and let Witch Cat lead you to riches!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732081597171.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WITCHCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCHCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

