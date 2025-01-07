module 0xb4df910d9e0e6d2809d348485d5a6ae0f200be668f108bd565acea0903101542::mbl {
    struct MBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBL>(arg0, 9, b"MBL", b"Maibullish", b"Mai bullish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8e70582-f88d-494b-9d4e-3718a9844f77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

