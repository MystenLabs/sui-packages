module 0xc031f4ff8771e0d0e3dddfa73ce4c590f06bfc194943ed092acb37f3a2339e36::hairy {
    struct HAIRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIRY>(arg0, 6, b"HAIRY", b"Wizard Sloth", b"Elons Musks favourite sloth: This meme coin is dedicated to the chilled sloth, which even Elon Musk has taken a liking to (see tweet). No matter when, how and where this sloth rides everything :-)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_3f28876023.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

