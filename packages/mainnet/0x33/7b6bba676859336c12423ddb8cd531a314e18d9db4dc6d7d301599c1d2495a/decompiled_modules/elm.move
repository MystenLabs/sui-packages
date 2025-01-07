module 0x337b6bba676859336c12423ddb8cd531a314e18d9db4dc6d7d301599c1d2495a::elm {
    struct ELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELM>(arg0, 9, b"ELM", b"Elemon", b"Ky Elemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e175b1e-e2f5-43fb-aa72-e338d2371029.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELM>>(v1);
    }

    // decompiled from Move bytecode v6
}

