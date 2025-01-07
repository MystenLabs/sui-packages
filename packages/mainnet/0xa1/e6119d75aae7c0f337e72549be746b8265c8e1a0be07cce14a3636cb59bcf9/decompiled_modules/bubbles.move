module 0xa1e6119d75aae7c0f337e72549be746b8265c8e1a0be07cce14a3636cb59bcf9::bubbles {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 6, b"BUBBLES", b"MOVE BUBBLES", b"In the BubbleVerse, tokens represent fragile, shimmering bubbles. Each bubble holds value, but can burst at any moment, releasing its value to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3757_d0cc403405.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

