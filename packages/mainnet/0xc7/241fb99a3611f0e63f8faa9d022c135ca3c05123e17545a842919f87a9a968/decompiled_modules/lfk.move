module 0xc7241fb99a3611f0e63f8faa9d022c135ca3c05123e17545a842919f87a9a968::lfk {
    struct LFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFK>(arg0, 9, b"LFK", b"LIGHT FACE", b"Understanding the concept of crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/098aedf4-a4d1-4406-b00a-22c09ab6f4d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

