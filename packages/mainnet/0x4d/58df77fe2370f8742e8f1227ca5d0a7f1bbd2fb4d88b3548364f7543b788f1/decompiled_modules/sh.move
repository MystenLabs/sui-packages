module 0x4d58df77fe2370f8742e8f1227ca5d0a7f1bbd2fb4d88b3548364f7543b788f1::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"HUNCHO ", b"Simply Greatness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30579802-910e-4c1a-87c8-f893ae7a5a8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

