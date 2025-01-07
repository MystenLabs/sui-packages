module 0x1832f8b8048fe0981498ba185abfdb1b951298533d6d9f06fe566dfd101a800::limi {
    struct LIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMI>(arg0, 9, b"LIMI", b"Limbine", b"Everything begins with honesty and continues with poetry and art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc16ffd3-d1fa-4c0b-a74b-fc802bc7fc0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

