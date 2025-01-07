module 0x143f569b2d5db2440498e66e15302256119eeb63a243c82c1f31165bc0d0fb8a::roolo {
    struct ROOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOLO>(arg0, 9, b"ROOLO", b"Branded", b"We are here for a take over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fffbcaa-573c-4b20-a42a-c31b21ae57b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

