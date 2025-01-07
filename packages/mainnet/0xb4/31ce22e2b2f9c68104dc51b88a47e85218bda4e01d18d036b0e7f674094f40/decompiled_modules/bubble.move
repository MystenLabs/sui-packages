module 0xb431ce22e2b2f9c68104dc51b88a47e85218bda4e01d18d036b0e7f674094f40::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"Bubble", b"Bubble PUP", b"Sticker Story  Bubble Pup is Back and Cuter Than Ever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sss_0e0bc780dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

