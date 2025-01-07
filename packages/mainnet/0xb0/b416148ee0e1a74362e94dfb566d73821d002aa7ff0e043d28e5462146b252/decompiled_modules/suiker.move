module 0xb0b416148ee0e1a74362e94dfb566d73821d002aa7ff0e043d28e5462146b252::suiker {
    struct SUIKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKER>(arg0, 6, b"Suiker", b"Joker sui", b"Joker on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9003_489c7c9852.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

