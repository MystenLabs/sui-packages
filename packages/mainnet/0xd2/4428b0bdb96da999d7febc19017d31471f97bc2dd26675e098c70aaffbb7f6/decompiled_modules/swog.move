module 0xd24428b0bdb96da999d7febc19017d31471f97bc2dd26675e098c70aaffbb7f6::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"Swog", b"Swog da frog", b"Swog da frog come to dominate the sui swamps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SWOG_0f1dd3fb4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

