module 0x6a9aac9b66fb50d962f0fc9815b49478e68a28450f15478850e4d0b7e9e0edf7::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"SuiPepe", x"68747470733a2f2f782e636f6d2f537569506570655375690a68747470733a2f2f742e6d652f5375695f506570655f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B97_F24_D1_1_BE_4_4_FC_5_8_C53_3069_C032_ACAA_b4952d40fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

