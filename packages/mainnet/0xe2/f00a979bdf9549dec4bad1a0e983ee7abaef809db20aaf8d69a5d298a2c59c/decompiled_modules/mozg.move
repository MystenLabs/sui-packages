module 0xe2f00a979bdf9549dec4bad1a0e983ee7abaef809db20aaf8d69a5d298a2c59c::mozg {
    struct MOZG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZG>(arg0, 9, b"MOZG", b"Mozg corp", b"Token MOZG corporation ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69d62978-e2c1-4b0d-a348-310e9b9db635.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOZG>>(v1);
    }

    // decompiled from Move bytecode v6
}

