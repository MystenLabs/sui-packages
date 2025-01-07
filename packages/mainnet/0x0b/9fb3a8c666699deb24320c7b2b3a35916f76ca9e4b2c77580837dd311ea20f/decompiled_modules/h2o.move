module 0xb9fb3a8c666699deb24320c7b2b3a35916f76ca9e4b2c77580837dd311ea20f::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 6, b"H2O", b"H20", x"54686520657373656e6365206f66206c696665206f6e2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hydrated_a6531ca53a_41464dcc9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

