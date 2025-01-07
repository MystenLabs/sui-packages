module 0x7bda3ace6354b2ca6d4a89a6cc3693c99e997433465f2a9e4049565e4e28dbc9::sdss {
    struct SDSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDSS>(arg0, 9, b"SDSS", b"SANDASS", b"Sociologist Community Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2c1a25a-32ab-4b18-a3dd-d9e7e9ccb0f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

