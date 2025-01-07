module 0x2d2fc57008060cb86378c92f119ba7d78b54af4c14d901946d7013e3566d9a46::thesuirfs {
    struct THESUIRFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THESUIRFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESUIRFS>(arg0, 6, b"THESUIRFS", b"TheSuirfs", b"Welcome in the Hidden Village of the SUIRFS! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rogr_CXQH_400x400_0b77dc356b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESUIRFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THESUIRFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

