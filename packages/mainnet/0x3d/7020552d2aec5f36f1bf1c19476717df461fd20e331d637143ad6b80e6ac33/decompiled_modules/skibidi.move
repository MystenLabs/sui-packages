module 0x3d7020552d2aec5f36f1bf1c19476717df461fd20e331d637143ad6b80e6ac33::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 9, b"SKIBIDI", b"Bincode61", b"Kahsmsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c1c5d08-40b7-43b4-9156-f52d96ff284f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

