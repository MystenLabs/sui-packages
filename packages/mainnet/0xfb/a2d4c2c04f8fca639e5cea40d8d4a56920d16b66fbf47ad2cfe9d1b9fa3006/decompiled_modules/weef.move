module 0xfba2d4c2c04f8fca639e5cea40d8d4a56920d16b66fbf47ad2cfe9d1b9fa3006::weef {
    struct WEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEF>(arg0, 9, b"WEEF", b"Wolf", b"The best in hunting me coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/953979bd-fcd2-42a9-9ecb-33f9ac4a9f6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

