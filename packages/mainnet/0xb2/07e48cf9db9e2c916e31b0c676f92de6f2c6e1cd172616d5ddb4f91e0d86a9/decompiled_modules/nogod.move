module 0xb207e48cf9db9e2c916e31b0c676f92de6f2c6e1cd172616d5ddb4f91e0d86a9::nogod {
    struct NOGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGOD>(arg0, 9, b"NOGOD", b"NO GOD", b"Atheism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42c7f341-c8e9-4445-937c-f336a3a6488e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

