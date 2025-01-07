module 0x9ee5d683d78daee4efeee5262855eddd672dd3ffba833d84a04c1b74e6628861::segual {
    struct SEGUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGUAL>(arg0, 6, b"SEGUAL", b"segual the whitepoop", b"Fish or hamburger i eat them all, just feed me good and i deliver some white poopy, get ready!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pexels_pixabay_56618_2a68d167b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEGUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

