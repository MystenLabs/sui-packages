module 0xa0b0e5e84fe2057903d0939b25607c239d7f33f0d8cb789fcd832380a5a1c71::dgsg {
    struct DGSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSG>(arg0, 9, b"DGSG", b"SGfh", b"GSGDSgsdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4c20b9d-fb21-47d2-a9ae-ee5c4917b4e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

