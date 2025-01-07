module 0x445a6472113f4bd90bb719a54189fb7dcd85e3847be60d0b1cf1bae6ac84c2d3::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"Suichi", b"suichi", b"the most memable cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4ed633e067.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

