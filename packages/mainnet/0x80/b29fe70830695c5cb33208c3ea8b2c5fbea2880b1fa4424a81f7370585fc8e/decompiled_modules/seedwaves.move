module 0x80b29fe70830695c5cb33208c3ea8b2c5fbea2880b1fa4424a81f7370585fc8e::seedwaves {
    struct SEEDWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDWAVES>(arg0, 9, b"SEEDWAVES", b"SeedWave", b"Latest trending meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9bbb0a8-02ff-4bd9-88cc-b889dbd6b3dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

