module 0xdbe382359c40a0bcff71388f0952907793001895cc888f84dbeb1c07a25aa7bd::ldg {
    struct LDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDG>(arg0, 9, b"LDG", b"Loading ", b"Load...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc5b947f-b8a6-42bd-b7d5-b3bef4f92d14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

