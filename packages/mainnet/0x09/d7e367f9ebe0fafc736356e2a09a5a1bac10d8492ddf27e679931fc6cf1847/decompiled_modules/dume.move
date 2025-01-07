module 0x9d7e367f9ebe0fafc736356e2a09a5a1bac10d8492ddf27e679931fc6cf1847::dume {
    struct DUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUME>(arg0, 9, b"DUME", b"DUCK", b"Meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85d08552-d211-4201-9e0c-419cd5180e2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

