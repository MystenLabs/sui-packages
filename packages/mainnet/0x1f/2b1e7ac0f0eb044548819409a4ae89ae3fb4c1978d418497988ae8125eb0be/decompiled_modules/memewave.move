module 0x1f2b1e7ac0f0eb044548819409a4ae89ae3fb4c1978d418497988ae8125eb0be::memewave {
    struct MEMEWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEWAVE>(arg0, 9, b"MEMEWAVE", b"WAVEDOG", b"A new hot meme coin by Wave On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5000fbce-9023-4bcb-a5be-c6573c78d00d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

