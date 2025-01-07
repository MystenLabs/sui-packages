module 0xc291a0f330af82207de27a71389f26a3e377817822bd63a47a21fcecb6f71062::nogod {
    struct NOGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGOD>(arg0, 9, b"NOGOD", b"NO GOD", b"Atheism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bc2f413-6b1e-4635-a9b1-d63226413a2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

