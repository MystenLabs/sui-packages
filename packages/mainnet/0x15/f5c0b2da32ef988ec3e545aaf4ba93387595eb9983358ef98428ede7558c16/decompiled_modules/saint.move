module 0x15f5c0b2da32ef988ec3e545aaf4ba93387595eb9983358ef98428ede7558c16::saint {
    struct SAINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAINT>(arg0, 9, b"SAINT", b"Franklin", b"Snowfall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/473292f3-9e7a-483d-9595-4e5f9bb70e12-1000001962.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

