module 0x18c3153b2c564028ec60c97ca32089afa78000338d77ae4f5c99945ca8a8816a::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"GREEN", b"Green coin", b"GreenCoin is a utility token designed to promote sustainable living and support environmental initiatives. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ea6c6e4-0593-4537-bb7e-aa727c226abc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

