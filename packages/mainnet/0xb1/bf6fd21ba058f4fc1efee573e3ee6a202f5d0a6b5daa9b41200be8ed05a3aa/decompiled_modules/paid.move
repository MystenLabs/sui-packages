module 0xb1bf6fd21ba058f4fc1efee573e3ee6a202f5d0a6b5daa9b41200be8ed05a3aa::paid {
    struct PAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAID>(arg0, 9, b"PAID", b"Paid guy", b"You guys get paid single frame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63118c35-7e3e-4526-bebe-6c604a911085.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

