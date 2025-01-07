module 0xc3cd90abe58dfdd1be3336b48c4adcfb7d5dab64b3528e491e62f7556c74db0d::sswap {
    struct SSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWAP>(arg0, 6, b"SSWAP", b"SUI SWAPME", b"Swap me for an estate, not for peanuts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_0fc889da_12d7_4fd6_b3ea_779f59657c72_png_7274605470.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSWAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSWAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

