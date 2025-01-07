module 0xc7ae2bcf3df170993185876cd6c841314a67faec2462b0098468b51dc4d9d37e::rasty {
    struct RASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASTY>(arg0, 6, b"RASTY", b"Rastopyry", b"Honoring Vitaliks first puppy, Rastopyry, with the ultimate meme coin on sui. Join the pack and stay for the fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048502_4d280a4270.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RASTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

