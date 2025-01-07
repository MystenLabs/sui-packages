module 0x5d68eeb3e033f46b5d4daceed0a859204913138d2f40322126cf1e3d9ae8f733::ppg {
    struct PPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPG>(arg0, 9, b"PPG", b"Pepegirl ", b"Most famous pepe girlfriend memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4db271c-0f2f-429e-810e-cdf06c1f34a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

