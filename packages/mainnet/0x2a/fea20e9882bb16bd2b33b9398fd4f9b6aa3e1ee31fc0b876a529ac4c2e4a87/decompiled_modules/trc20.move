module 0x2afea20e9882bb16bd2b33b9398fd4f9b6aa3e1ee31fc0b876a529ac4c2e4a87::trc20 {
    struct TRC20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRC20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRC20>(arg0, 9, b"TRC20", b"TRC2", b"The sui Tsunami enjoy the mem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a374f9c-2698-4168-8c6a-33f95c33a36f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRC20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRC20>>(v1);
    }

    // decompiled from Move bytecode v6
}

