module 0xc1993dd5cec2916347fdf5f6a7cad4733fddf8b4193b2928ffc57f2d9bdd4cf4::bitdog {
    struct BITDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITDOG>(arg0, 6, b"BITDOG", b"Bitdog on SUI", b"The goodest hero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l4_XLIM_Yy_400x400_c0d044d5f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

