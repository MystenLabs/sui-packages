module 0x625b5023f7a0086e6ba2702ebb8568d2913f566569b10f23806efafc3ec7b158::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 6, b"EGGS", b"EGG", b"buy this EGG if you tired - SUI community driven -", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngtree_salted_duck_eggs_png_image_2457307_e56b166933.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

