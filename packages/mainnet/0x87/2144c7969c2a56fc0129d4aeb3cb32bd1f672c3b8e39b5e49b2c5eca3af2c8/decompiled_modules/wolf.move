module 0x872144c7969c2a56fc0129d4aeb3cb32bd1f672c3b8e39b5e49b2c5eca3af2c8::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 9, b"WOLF", b"wolf", b"market shaggy wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6983f5fa-452a-4bd8-acf3-23ce936f7469.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

