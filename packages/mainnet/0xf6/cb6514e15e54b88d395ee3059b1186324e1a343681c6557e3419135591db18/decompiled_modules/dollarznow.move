module 0xf6cb6514e15e54b88d395ee3059b1186324e1a343681c6557e3419135591db18::dollarznow {
    struct DOLLARZNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLARZNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLARZNOW>(arg0, 9, b"DOLLARZNOW", b"Hamish", b"It's all in the name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d90b02b0-1c49-41c2-8ec6-2d48b5d363f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLARZNOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLARZNOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

