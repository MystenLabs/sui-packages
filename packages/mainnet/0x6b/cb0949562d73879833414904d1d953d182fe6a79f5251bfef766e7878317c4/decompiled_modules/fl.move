module 0x6bcb0949562d73879833414904d1d953d182fe6a79f5251bfef766e7878317c4::fl {
    struct FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL>(arg0, 9, b"FL", b"Florida", b"Let's send a rescue team now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5f75b0b-e4e2-40c7-ac6e-cdf5a22df66e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL>>(v1);
    }

    // decompiled from Move bytecode v6
}

