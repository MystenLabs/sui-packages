module 0x5d222ff0816eb35da9c5f4c1a3aede322be31666ffbe863830c86a1dc58fc2f0::mioo {
    struct MIOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOO>(arg0, 9, b"MIOO", b"Tito", b"Mimiioooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5733e6d7-0ae7-4af3-ae1c-5376a854ceca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

