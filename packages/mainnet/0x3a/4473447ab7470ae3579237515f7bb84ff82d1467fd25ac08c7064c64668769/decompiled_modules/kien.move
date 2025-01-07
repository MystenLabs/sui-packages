module 0x3a4473447ab7470ae3579237515f7bb84ff82d1467fd25ac08c7064c64668769::kien {
    struct KIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIEN>(arg0, 9, b"KIEN", x"4be1bb896e6d656d65", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3d51460-06a2-452e-8382-44edf7d0c04e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

