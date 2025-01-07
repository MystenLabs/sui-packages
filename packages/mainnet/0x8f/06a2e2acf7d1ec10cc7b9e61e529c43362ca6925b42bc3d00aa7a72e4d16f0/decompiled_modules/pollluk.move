module 0x8f06a2e2acf7d1ec10cc7b9e61e529c43362ca6925b42bc3d00aa7a72e4d16f0::pollluk {
    struct POLLLUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLLUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLLUK>(arg0, 6, b"POLLLUK", b"PoLLUK", b"I am PoLLUK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5549cd0e_edf4_46f0_970d_45c49e77695a_eb012b2c45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLLUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLLLUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

