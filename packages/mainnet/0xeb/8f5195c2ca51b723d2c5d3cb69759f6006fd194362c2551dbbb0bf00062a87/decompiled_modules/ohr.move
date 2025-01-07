module 0xeb8f5195c2ca51b723d2c5d3cb69759f6006fd194362c2551dbbb0bf00062a87::ohr {
    struct OHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHR>(arg0, 9, b"OHR", b"Oharu", b"OHARU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5848e07d-788d-4f48-80f8-ae2d3272a0f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

