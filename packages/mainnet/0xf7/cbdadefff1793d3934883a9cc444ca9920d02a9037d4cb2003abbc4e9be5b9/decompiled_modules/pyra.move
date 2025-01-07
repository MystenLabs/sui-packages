module 0xf7cbdadefff1793d3934883a9cc444ca9920d02a9037d4cb2003abbc4e9be5b9::pyra {
    struct PYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYRA>(arg0, 9, b"PYRA", b"Capybara", b"I like ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/244109ca-afc0-47d4-924d-9ccce039f778.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

