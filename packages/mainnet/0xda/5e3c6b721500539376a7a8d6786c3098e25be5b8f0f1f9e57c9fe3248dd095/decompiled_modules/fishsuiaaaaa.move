module 0xda5e3c6b721500539376a7a8d6786c3098e25be5b8f0f1f9e57c9fe3248dd095::fishsuiaaaaa {
    struct FISHSUIAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHSUIAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSUIAAAAA>(arg0, 6, b"FISHSUIAAAAA", b"AAAAFISHSUI", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_025117478_6cee5a2e23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSUIAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHSUIAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

