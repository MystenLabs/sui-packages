module 0xe91ae8afcda1bddd85edb9156cbcd1d1f8c667de7247e3922f63cab5ad7bd553::ropo {
    struct ROPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROPO>(arg0, 9, b"ROPO", b"Ropopo", b"Meme's ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9cbe208-4908-40cb-9d3f-2c6a47fd062c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

