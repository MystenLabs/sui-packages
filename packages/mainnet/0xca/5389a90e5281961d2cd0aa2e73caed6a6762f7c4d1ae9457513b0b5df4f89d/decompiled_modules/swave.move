module 0xca5389a90e5281961d2cd0aa2e73caed6a6762f7c4d1ae9457513b0b5df4f89d::swave {
    struct SWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAVE>(arg0, 9, b"SWAVE", b"Suiwave", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0dfe238-0603-4cce-aa27-c26af8f1af4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

