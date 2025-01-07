module 0x458d56b699f1c50a209fb1768dbe826d753c13e8f8b609fce471c4d2bcd3a223::mioo {
    struct MIOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOO>(arg0, 9, b"MIOO", b"Tito", b"Mimiioooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/959d82b6-6f2a-45ab-842e-91f700e9f920.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

