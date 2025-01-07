module 0xc728b75d3f63d890852fca65e21afece5afb61a49d5b0e0634ee359fba6e7a73::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 6, b"FLAME", b"Smiling FLAME", b"Little flame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flame_pixel_test_c03e30ec21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

