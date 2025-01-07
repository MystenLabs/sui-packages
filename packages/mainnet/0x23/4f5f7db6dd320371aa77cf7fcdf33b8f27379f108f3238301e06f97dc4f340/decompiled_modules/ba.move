module 0x234f5f7db6dd320371aa77cf7fcdf33b8f27379f108f3238301e06f97dc4f340::ba {
    struct BA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BA>(arg0, 9, b"BA", b"Bae", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7891b70a-151d-4212-ae47-14f7a89d56e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BA>>(v1);
    }

    // decompiled from Move bytecode v6
}

