module 0xd6f2e78f76dd88a96397109c66e1f23181e2d8f2b85a73ed6039af943ce7ce70::plol {
    struct PLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOL>(arg0, 9, b"PLOL", b"SPECIAL", b"SPECIAL PERMIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddc58126-0adb-4514-a97c-1d02b38bcd44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

