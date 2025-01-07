module 0x9148856dd88db88bb4d6f70e9c735cb4c21cd1c6cc0902e4bb85855cbfc6420a::mederajij {
    struct MEDERAJIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDERAJIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDERAJIJ>(arg0, 9, b"MEDERAJIJ", b"Majij", b"meeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70634086-aa40-4a29-a83d-969d9c05fe24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDERAJIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEDERAJIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

