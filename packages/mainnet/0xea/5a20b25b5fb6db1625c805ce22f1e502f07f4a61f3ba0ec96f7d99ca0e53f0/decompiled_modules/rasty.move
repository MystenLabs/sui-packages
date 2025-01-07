module 0xea5a20b25b5fb6db1625c805ce22f1e502f07f4a61f3ba0ec96f7d99ca0e53f0::rasty {
    struct RASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASTY>(arg0, 6, b"RASTY", b"Rastopyry", b"Honoring Vitaliks first puppy, Rastopyry, with the ultimate meme coin on sui. Join the pack and stay for the fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048501_6e7a3e746f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RASTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

