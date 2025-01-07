module 0x50dccfecfd3b1b2aecbdc32d8bff2dac8ac2f235cae64435f70e93ff65260621::dollarznow {
    struct DOLLARZNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLARZNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLARZNOW>(arg0, 9, b"DOLLARZNOW", b"Hamish", b"It's all in the name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00fe260f-c71d-4935-818e-324e2c0b9066.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLARZNOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLARZNOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

