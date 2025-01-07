module 0x38f5b5410b8e365e4a20f5b0d87aafbcd587a9b684e541daf325541a07611ae4::wiiwi {
    struct WIIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIIWI>(arg0, 9, b"WIIWI", b"Wifiwi", b"A token For fun lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/100bfea0-b454-44d9-be6e-41d7ad3f6d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

