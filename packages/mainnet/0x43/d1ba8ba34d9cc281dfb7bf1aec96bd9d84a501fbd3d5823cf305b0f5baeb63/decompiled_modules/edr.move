module 0x43d1ba8ba34d9cc281dfb7bf1aec96bd9d84a501fbd3d5823cf305b0f5baeb63::edr {
    struct EDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDR>(arg0, 9, b"EDR", b"TIRED", b"there is no talk of buying my meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c56087dc-eb1a-4745-8a0c-f9d23fc22c03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

