module 0x1fefabf9f4af9387ef7ac3f925112e15143b4f16521c04608ea43df7b7bf1cbd::bkz {
    struct BKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKZ>(arg0, 9, b"BKZ", b"BOIKUKIZ ", b"A meme made with love with a vision to grow in the nearest future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/982b89e2-0111-4007-bcf9-568fbdb24452.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

