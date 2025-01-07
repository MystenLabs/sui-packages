module 0xdc0546a5dddac003b5a1b77b86b285588b6636abda1845878fc85bc5cb1c792b::stiny {
    struct STINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINY>(arg0, 6, b"STINY", b"StinyDog Sui", b"$STINY is a cute little dog token on sui blockchain, full of fur and magic. Small in size but big in personality, this cute dog is ready to explore with you. Bring $STINY into your collection, enjoy the most charming Sui companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001357_b2cb2285c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

