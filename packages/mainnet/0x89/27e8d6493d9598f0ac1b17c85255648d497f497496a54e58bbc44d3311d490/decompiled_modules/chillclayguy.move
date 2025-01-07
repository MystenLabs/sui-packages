module 0x8927e8d6493d9598f0ac1b17c85255648d497f497496a54e58bbc44d3311d490::chillclayguy {
    struct CHILLCLAYGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLCLAYGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLCLAYGUY>(arg0, 6, b"CHILLCLAYGUY", b"Chill Clay Guy on Sui", b"handmade plastic art of the Chill Guy meme, let's support art, join our community...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043428_68da866284.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLCLAYGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLCLAYGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

