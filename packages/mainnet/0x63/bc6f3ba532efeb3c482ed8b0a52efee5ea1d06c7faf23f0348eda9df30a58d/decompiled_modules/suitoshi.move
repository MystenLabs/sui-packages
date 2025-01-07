module 0x63bc6f3ba532efeb3c482ed8b0a52efee5ea1d06c7faf23f0348eda9df30a58d::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"Suitoshi Nakamoto", b"\"Suitoshi Nakamoto\" is a mix of Satoshi Nakamoto (the pseudonymous creator of Bitcoin) And Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_12_12_29_01_d9c4b748bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

