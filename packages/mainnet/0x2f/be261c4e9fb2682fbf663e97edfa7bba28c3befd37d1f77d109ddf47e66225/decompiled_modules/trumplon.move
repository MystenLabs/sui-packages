module 0x2fbe261c4e9fb2682fbf663e97edfa7bba28c3befd37d1f77d109ddf47e66225::trumplon {
    struct TRUMPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLON>(arg0, 9, b"TRUMPLON", b"Trump Elon", b"This tokeb support Trump n Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09114881-32c3-40be-9933-45f3f814e26e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

