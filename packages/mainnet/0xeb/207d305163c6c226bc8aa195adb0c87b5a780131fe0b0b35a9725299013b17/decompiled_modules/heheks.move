module 0xeb207d305163c6c226bc8aa195adb0c87b5a780131fe0b0b35a9725299013b17::heheks {
    struct HEHEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHEKS>(arg0, 9, b"HEHEKS", b"HEHEIK", b"THAT THIS WHEN DO I YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7502104f-4447-48b6-adbb-11aa2fa4c9d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

