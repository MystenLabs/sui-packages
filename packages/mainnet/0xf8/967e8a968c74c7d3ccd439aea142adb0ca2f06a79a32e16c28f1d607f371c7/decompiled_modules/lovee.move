module 0xf8967e8a968c74c7d3ccd439aea142adb0ca2f06a79a32e16c28f1d607f371c7::lovee {
    struct LOVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVEE>(arg0, 9, b"LOVEE", b"Love", b"Haha love you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c4b89bb-c45e-4791-a3df-9158cfba5ecc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

