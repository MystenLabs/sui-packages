module 0x6c7a86a63fd430961d0ba5c4ef65d1576814e92dcd90211ac620c2aa707299cb::mioo {
    struct MIOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOO>(arg0, 9, b"MIOO", b"Tito", b"Mimiioooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a44135fd-fa0d-4a74-8bd9-6a1f09061c14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

