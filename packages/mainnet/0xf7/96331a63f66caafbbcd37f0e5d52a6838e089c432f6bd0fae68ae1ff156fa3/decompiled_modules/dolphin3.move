module 0xf796331a63f66caafbbcd37f0e5d52a6838e089c432f6bd0fae68ae1ff156fa3::dolphin3 {
    struct DOLPHIN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN3>(arg0, 9, b"DOLPHIN3", b"Dolphin ", b"Dolphins on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d665d58-8b7c-4d7d-b169-1bcb2c2c88d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHIN3>>(v1);
    }

    // decompiled from Move bytecode v6
}

