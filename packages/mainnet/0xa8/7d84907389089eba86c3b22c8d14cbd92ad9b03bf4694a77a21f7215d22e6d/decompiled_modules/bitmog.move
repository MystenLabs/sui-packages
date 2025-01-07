module 0xa87d84907389089eba86c3b22c8d14cbd92ad9b03bf4694a77a21f7215d22e6d::bitmog {
    struct BITMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMOG>(arg0, 6, b"BITMOG", b"8-Bit Mog", b"The 8-bit version of the MOG meme coin adds a playful, retro twist with classic pixel art, bringing back the old-school video game vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_24_10_51_40_b42dcac60a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

