module 0x9a82773d11eee2e165e3298edbc0d20f002d3aa0baccef74431ff0e54a6da8ce::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Fishman", b"I am Fishman.  I live in Sui. I am Happy. I am Strong and Confident.  I love Turtles.  I am Sexy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sanrio_Characters_Hangyodon_Image002_7a46ae35e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

