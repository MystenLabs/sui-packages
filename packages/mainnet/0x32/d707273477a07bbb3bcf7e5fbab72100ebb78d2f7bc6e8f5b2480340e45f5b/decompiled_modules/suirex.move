module 0x32d707273477a07bbb3bcf7e5fbab72100ebb78d2f7bc6e8f5b2480340e45f5b::suirex {
    struct SUIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREX>(arg0, 6, b"SuiRex", b"SuiOsaur", b"Just your friendly Blue dinosaur trying to navigate the Sui seas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241030_101037_ac58ad25bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

