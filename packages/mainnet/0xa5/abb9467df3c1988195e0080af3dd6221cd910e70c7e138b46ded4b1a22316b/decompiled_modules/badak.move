module 0xa5abb9467df3c1988195e0080af3dd6221cd910e70c7e138b46ded4b1a22316b::badak {
    struct BADAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADAK>(arg0, 9, b"BADAK", b"Badak", b"Badak kewan jowo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b365d7fe-d69d-4b71-98ab-adb0ed52953a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

