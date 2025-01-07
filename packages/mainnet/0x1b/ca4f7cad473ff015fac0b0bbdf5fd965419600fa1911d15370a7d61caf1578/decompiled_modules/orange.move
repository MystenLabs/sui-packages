module 0x1bca4f7cad473ff015fac0b0bbdf5fd965419600fa1911d15370a7d61caf1578::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 9, b"ORANGE", b"ORANGE SUI", b"orange sui is the best meme of the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8ab993a-ca1c-4336-82e8-3f0d0d0a4215.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

