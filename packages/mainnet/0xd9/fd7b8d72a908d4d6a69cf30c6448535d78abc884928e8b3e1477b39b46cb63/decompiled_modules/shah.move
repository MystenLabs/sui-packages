module 0xd9fd7b8d72a908d4d6a69cf30c6448535d78abc884928e8b3e1477b39b46cb63::shah {
    struct SHAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAH>(arg0, 9, b"SHAH", b"Shiushan", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc416e21-e875-4451-b61e-3db1541b0b97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

