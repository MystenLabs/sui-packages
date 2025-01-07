module 0x58ee87148acac7f21c542bba6bca0f2b6bffb82c19ef330e1ccdd8ed132e5732::dffdsh {
    struct DFFDSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFDSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFDSH>(arg0, 9, b"DFFDSH", b"KJHJF", b"BBCDH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c877f2d-d050-451f-975d-99dbb1360f2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFDSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFDSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

