module 0xc83732ee3e9480224c57810c5da0cabc0a8fa65cd3b501b3ec3bece802f9c8e::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"Cat Ai by SuiAI", b"The meme token made by the community, for the community on Sui Network. Together, we grow and succeed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/favicon_093c1ca4d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

