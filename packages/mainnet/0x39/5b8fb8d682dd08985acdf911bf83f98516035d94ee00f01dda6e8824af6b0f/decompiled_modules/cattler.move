module 0x395b8fb8d682dd08985acdf911bf83f98516035d94ee00f01dda6e8824af6b0f::cattler {
    struct CATTLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTLER>(arg0, 6, b"Cattler", b"Adolf CATTLER", b"My cat looked a lot like adolf h--ler so I made a meme out of it to keep it on the web forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z30396cl5el31_fb01f48825.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATTLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

