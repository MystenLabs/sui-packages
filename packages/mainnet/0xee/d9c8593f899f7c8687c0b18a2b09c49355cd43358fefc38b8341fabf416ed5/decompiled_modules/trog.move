module 0xeed9c8593f899f7c8687c0b18a2b09c49355cd43358fefc38b8341fabf416ed5::trog {
    struct TROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROG>(arg0, 6, b"TROG", b"TROG SUI", b"Welcome to the wacky, wild world of Trog (Trump Frog) - the meme coin thats here to make crypto great again! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2077d81d0c5258230d5a195233941547cb5f0989_6f73cf5ef0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

