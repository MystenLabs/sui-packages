module 0x14f8828708df64b1b433f834d3d7b94cd06e5f0d8bf6001c9b4f460c6df946b9::seedwaves {
    struct SEEDWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDWAVES>(arg0, 9, b"SEEDWAVES", b"SeedWave", b"Latest trending meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a6a94a0-bdf7-429a-ad1a-bacedc3af767.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

