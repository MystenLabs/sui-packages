module 0xfcec09e2935f65ff862b82197730eecf19245b7584235469f2cd6a95e1b715e0::starbrave_ {
    struct STARBRAVE_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARBRAVE_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARBRAVE_>(arg0, 9, b"STARBRAVE_", b"StarStar", b"New thing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bca7fabd-44bc-4d12-81a9-e128fb482529.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARBRAVE_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARBRAVE_>>(v1);
    }

    // decompiled from Move bytecode v6
}

