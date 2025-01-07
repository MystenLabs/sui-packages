module 0xac0d8c94b6030ea9bc17ab4890f08bd3ff7e3d92fb6e6c9b493db2fa7f0f6e8e::seedwaves {
    struct SEEDWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDWAVES>(arg0, 9, b"SEEDWAVES", b"SeedWave", b"Latest trending meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56dcca19-b387-45ae-b93e-f8a5aefdc7aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

