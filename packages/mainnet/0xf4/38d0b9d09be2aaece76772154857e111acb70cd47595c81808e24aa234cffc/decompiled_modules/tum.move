module 0xf438d0b9d09be2aaece76772154857e111acb70cd47595c81808e24aa234cffc::tum {
    struct TUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUM>(arg0, 9, b"TUM", b"Turtle", b"Turtle meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd866b2c-ca5e-45eb-a88f-5e6376f53798.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

