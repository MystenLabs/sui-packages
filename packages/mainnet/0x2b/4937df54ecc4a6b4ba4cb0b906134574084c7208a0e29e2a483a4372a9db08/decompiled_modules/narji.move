module 0x2b4937df54ecc4a6b4ba4cb0b906134574084c7208a0e29e2a483a4372a9db08::narji {
    struct NARJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARJI>(arg0, 9, b"NARJI", b"Narjiboy", b"Narjiboy is miliaderboy , he king clowns, short 34 k to 73 k periods Oktober 2023-Maret 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b6cb963-4983-4a46-b1e7-54f81a1c620c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NARJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

