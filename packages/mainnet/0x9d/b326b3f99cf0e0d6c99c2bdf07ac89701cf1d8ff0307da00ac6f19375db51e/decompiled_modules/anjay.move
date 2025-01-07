module 0x9db326b3f99cf0e0d6c99c2bdf07ac89701cf1d8ff0307da00ac6f19375db51e::anjay {
    struct ANJAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJAY>(arg0, 9, b"ANJAY", b"AENJEAYE", b"Start crazy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d9e99df-6c3c-420d-be3a-8da1855f221c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

