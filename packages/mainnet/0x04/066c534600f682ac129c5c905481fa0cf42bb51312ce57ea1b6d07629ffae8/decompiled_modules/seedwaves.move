module 0x4066c534600f682ac129c5c905481fa0cf42bb51312ce57ea1b6d07629ffae8::seedwaves {
    struct SEEDWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDWAVES>(arg0, 9, b"SEEDWAVES", b"SeedWave", b"Latest trending meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/010a5288-f6c6-400c-abfb-8625e182bd14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

