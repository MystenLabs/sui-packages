module 0xe67cc0b8b4f2531d7954727fa90b40c3d596cb33882dfd4dd01f8637bd4d0124::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 9, b"BUL", b"Bullar", b"Encouraging people to dive in to the crypto wolrdz especially in this season, who knows were the bull will stop it the run starts???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0270e0c6-d062-4ce2-b45c-35b3c7b0e780.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

