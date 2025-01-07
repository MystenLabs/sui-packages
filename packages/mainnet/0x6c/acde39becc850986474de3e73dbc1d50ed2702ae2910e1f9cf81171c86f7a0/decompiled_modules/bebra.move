module 0x6cacde39becc850986474de3e73dbc1d50ed2702ae2910e1f9cf81171c86f7a0::bebra {
    struct BEBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBRA>(arg0, 9, b"BEBRA", b"bebra", b"Bebra Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c0691b8-617c-44e2-a4e6-56895c36f44d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

