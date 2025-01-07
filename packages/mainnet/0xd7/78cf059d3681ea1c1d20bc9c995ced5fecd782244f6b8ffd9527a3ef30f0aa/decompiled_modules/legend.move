module 0xd778cf059d3681ea1c1d20bc9c995ced5fecd782244f6b8ffd9527a3ef30f0aa::legend {
    struct LEGEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGEND>(arg0, 9, b"LEGEND", b"MEGALODON", x"4d656d652070756d7020636f696e20f09f94a5f09f94a5f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d54d6d4-ffcf-4810-bf55-9c78c8d8952c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

