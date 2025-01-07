module 0xa77bb29a17adf53689c8202f983200c032bfa41efba9d90e7a8f43c13518a17f::jg {
    struct JG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JG>(arg0, 9, b"JG", b"XC", b"VB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d6c6088-e912-48aa-8d7f-7eff1f4f667c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JG>>(v1);
    }

    // decompiled from Move bytecode v6
}

