module 0x68666886966cb246e8e917dc04cc43e8619676c99f6ed9d42f1382878172bf9e::mioo {
    struct MIOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOO>(arg0, 9, b"MIOO", b"Tito", b"Mimiioooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0323010-8478-45ff-8f21-b2a1a413d519.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

