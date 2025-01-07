module 0x986a006efdce0e7a1c915227215d7b81c478e32608433cae026fd0c2d2e3840b::dwog {
    struct DWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOG>(arg0, 6, b"DWOG", b"DWOG SUI", x"77776f6f6f6f6f6f6f7272666620617777726666206177727272660a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_22_22_32_7774fc494e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

