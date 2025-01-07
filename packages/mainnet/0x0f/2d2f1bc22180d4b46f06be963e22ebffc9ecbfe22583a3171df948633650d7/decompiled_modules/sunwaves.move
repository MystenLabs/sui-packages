module 0xf2d2f1bc22180d4b46f06be963e22ebffc9ecbfe22583a3171df948633650d7::sunwaves {
    struct SUNWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNWAVES>(arg0, 9, b"SUNWAVES", b"Web meme", b"Sunwaves is meme token apps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3794a60e-f0d7-4d5f-bfb1-333735cf7107.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

