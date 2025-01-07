module 0x43ad85321b2bf9cca2b0b1a5711b1fba6be9b61d47495c5bd8ba1c9e1adfcdf8::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"Bubble", b"Bubble On Sui", x"5374617920636f6f6c206f6e200a405375694e6574776f726b0a20776974682024427562626c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_22_28_51_1b4489d4e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

