module 0x7445894d55c1a77f1ba15f030b6bb0b1df85b1ecc1e719c82a492cdb5b30763b::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 6, b"DOM", b"DOM SUI", b"DOMS are 8,888 unique digital portraits, released as tokenized digital artworks. Pick your favorite DOMSONG and let your DOM blast It forever! DYNAMIC ORIGINAL MIND SETS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOMS_a8f6a062f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

