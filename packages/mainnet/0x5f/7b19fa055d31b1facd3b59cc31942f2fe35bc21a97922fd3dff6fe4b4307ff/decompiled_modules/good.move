module 0x5f7b19fa055d31b1facd3b59cc31942f2fe35bc21a97922fd3dff6fe4b4307ff::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 9, b"GOOD", b"Crab", b"Hi Crab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db3052d5-9e3d-4094-b110-ab2372d65cec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

