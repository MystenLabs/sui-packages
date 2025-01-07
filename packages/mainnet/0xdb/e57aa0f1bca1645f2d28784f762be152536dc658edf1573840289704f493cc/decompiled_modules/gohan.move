module 0xdbe57aa0f1bca1645f2d28784f762be152536dc658edf1573840289704f493cc::gohan {
    struct GOHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOHAN>(arg0, 6, b"GOHAN", b"Gohan on sui", b"Gohan isn't just a meme coin, it's a community that believes the best things happen when people laugh together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054208_f6809a5afa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

