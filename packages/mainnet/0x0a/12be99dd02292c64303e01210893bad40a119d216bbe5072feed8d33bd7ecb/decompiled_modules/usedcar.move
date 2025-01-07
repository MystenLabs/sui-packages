module 0xa12be99dd02292c64303e01210893bad40a119d216bbe5072feed8d33bd7ecb::usedcar {
    struct USEDCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: USEDCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USEDCAR>(arg0, 9, b"USEDCAR", b"used car", b"a gently used 2001 honda civic car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5353676c-e27e-45e1-ab31-5ff798b7fbda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USEDCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USEDCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

