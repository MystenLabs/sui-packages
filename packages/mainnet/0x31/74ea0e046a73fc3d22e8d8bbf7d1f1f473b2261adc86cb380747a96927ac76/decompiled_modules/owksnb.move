module 0x3174ea0e046a73fc3d22e8d8bbf7d1f1f473b2261adc86cb380747a96927ac76::owksnb {
    struct OWKSNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKSNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKSNB>(arg0, 9, b"OWKSNB", b"isksn", b"hsjanwb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41e46964-0bef-409b-b905-a8419b2d3682.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKSNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKSNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

