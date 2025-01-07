module 0x2cb3b1440d820f41d9ada406fea6d6cec5449d9c5784c8326238391759d1e75e::clths {
    struct CLTHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLTHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLTHS>(arg0, 6, b"CLTHS", b"Sui Clothes", b"I need support for my produk, Thanks :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B1_HVV_Uy_L_Ah_L_C_La_2140_2000_61p_R5fk_OC_1_L_png_0_0_2140_2000_0_0_0_0_2140_0_2000_0_AC_SX_466_b1f2c0e75a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLTHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLTHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

