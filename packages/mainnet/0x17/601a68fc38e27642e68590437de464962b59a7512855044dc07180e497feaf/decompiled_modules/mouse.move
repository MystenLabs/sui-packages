module 0x17601a68fc38e27642e68590437de464962b59a7512855044dc07180e497feaf::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSE>(arg0, 9, b"MOUSE", b"minimouse", b"a cute animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/422c4e08-ed38-45c8-955b-9c27f365ae71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

