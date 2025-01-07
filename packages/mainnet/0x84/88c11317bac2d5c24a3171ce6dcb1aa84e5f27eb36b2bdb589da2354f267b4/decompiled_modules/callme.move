module 0x8488c11317bac2d5c24a3171ce6dcb1aa84e5f27eb36b2bdb589da2354f267b4::callme {
    struct CALLME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALLME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALLME>(arg0, 9, b"CALLME", b"Call me", b"Call me may be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/511ad751-5f0e-4e20-b78c-16d1e9724702.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALLME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CALLME>>(v1);
    }

    // decompiled from Move bytecode v6
}

