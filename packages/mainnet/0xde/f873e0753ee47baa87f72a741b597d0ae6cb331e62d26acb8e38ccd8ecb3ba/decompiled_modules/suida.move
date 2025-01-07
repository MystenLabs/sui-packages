module 0xdef873e0753ee47baa87f72a741b597d0ae6cb331e62d26acb8e38ccd8ecb3ba::suida {
    struct SUIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDA>(arg0, 9, b"SUIDA", b"Sui Ishida", b"Sui Ishida is a Japanese manga artist. He is popularly known for his dark fantasy manga series Tokyo Ghoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fe8752d-f38d-4271-b2aa-662e8def73a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

