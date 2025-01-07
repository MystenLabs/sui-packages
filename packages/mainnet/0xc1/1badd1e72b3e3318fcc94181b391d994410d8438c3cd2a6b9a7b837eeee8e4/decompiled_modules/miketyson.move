module 0xc11badd1e72b3e3318fcc94181b391d994410d8438c3cd2a6b9a7b837eeee8e4::miketyson {
    struct MIKETYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKETYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKETYSON>(arg0, 9, b"MIKETYSON", b" Mike", b"Mike Tyson supporters token, I love Mike and you? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c33321b-6cf9-4372-986f-855d48a41809.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKETYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKETYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

