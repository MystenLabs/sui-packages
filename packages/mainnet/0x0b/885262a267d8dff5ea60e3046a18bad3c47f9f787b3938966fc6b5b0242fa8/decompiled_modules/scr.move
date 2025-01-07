module 0xb885262a267d8dff5ea60e3046a18bad3c47f9f787b3938966fc6b5b0242fa8::scr {
    struct SCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCR>(arg0, 9, b"SCR", b"Scorpion", x"47726561742053636f7270696f6e20e2998f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0a0a3ae-2c33-47d0-8fcd-2846a4cc1097.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

