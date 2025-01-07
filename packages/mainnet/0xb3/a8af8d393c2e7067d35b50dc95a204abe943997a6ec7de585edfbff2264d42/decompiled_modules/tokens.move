module 0xb3a8af8d393c2e7067d35b50dc95a204abe943997a6ec7de585edfbff2264d42::tokens {
    struct TOKENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKENS>(arg0, 9, b"TOKENS", b"Tokens mew", b"Watch later ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac865c1e-f90c-45f2-8ebe-75c863c803a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

