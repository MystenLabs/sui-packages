module 0x1893d318cc3ae917e1c705cbec98f5d5dcc0b2cec2bc17efb638f1d0072d2880::bsjajsjsn {
    struct BSJAJSJSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSJAJSJSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSJAJSJSN>(arg0, 9, b"BSJAJSJSN", b"Abbasbsb", b"Bdjnshsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa2a0561-c0a7-4c9d-ae27-40ba10320306.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSJAJSJSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSJAJSJSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

