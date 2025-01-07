module 0x46b5c3255fa0e5e6b08e8432e4f6b2648374580c9766438802ecba9f084d9c85::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEPE>(arg0, 6, b"wPEPE", b"wPEPE Terminal", b"An AI Frog from the Truth Terminal. All AI tech is in this PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_28_00_16_41_e873dea441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

