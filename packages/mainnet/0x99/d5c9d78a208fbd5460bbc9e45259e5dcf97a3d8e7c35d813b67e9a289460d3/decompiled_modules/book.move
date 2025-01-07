module 0x99d5c9d78a208fbd5460bbc9e45259e5dcf97a3d8e7c35d813b67e9a289460d3::book {
    struct BOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOK>(arg0, 9, b"BOOK", b"Book", b"BOOK Only in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6dd3f784-1e6e-4927-92d1-2d203c937ef7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

