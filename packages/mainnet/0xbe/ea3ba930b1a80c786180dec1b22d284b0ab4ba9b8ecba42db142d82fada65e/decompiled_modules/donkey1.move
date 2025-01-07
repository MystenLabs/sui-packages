module 0xbeea3ba930b1a80c786180dec1b22d284b0ab4ba9b8ecba42db142d82fada65e::donkey1 {
    struct DONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY1>(arg0, 9, b"DONKEY1", b"Donkey ", b"For you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7132183-6b4e-4759-b958-53ba1fa1a43a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

