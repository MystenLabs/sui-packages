module 0x990f9b4f7d467ce3a44e6e490a178a32511e290a8c99014a16cea05c046674f4::glep {
    struct GLEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLEP>(arg0, 6, b"Glep", b"GlepOnSui", b"Just Glep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_26_18_23_33_51363d1781.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

