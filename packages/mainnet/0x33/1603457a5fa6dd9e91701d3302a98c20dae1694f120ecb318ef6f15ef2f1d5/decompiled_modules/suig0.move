module 0x331603457a5fa6dd9e91701d3302a98c20dae1694f120ecb318ef6f15ef2f1d5::suig0 {
    struct SUIG0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG0>(arg0, 9, b"SUIG0", b"SuiG0 Toke", b"Token that boom later", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15f2ccd2-ffd1-48f4-a0b2-14984f462440.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIG0>>(v1);
    }

    // decompiled from Move bytecode v6
}

