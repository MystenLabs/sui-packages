module 0xaf68204b5f227e98595fe7b690db5bb5d6aba94185401b4df2d595d5d49f4d2::slizzy {
    struct SLIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIZZY>(arg0, 6, b"SLIZZY", b"SLIZZY SUI", b"SLIZZY ADVENTURES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6687_2e780a9de2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

