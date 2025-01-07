module 0x27f4bab09ceea87097ff3ff6874055f625acda7bae53745b91c952949a097d2a::bubbles {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 6, b"BUBBLES", b"BUBBLES BUBE", b"In the BubbleVerse, tokens represent fragile, shimmering bubbles. Each bubble holds value, but can burst at any moment, releasing its value to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3815_aecbd8c29c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

