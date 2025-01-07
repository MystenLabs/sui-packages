module 0xe95cac96079f3bffbfce760a79f125666e68875107b2e624f2f927f5e4b0e724::strange {
    struct STRANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRANGE>(arg0, 9, b"STRANGE", b"Strange", b"Dr. STRANGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eadac3f9-d118-4cfa-a1b4-db9813e645e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

