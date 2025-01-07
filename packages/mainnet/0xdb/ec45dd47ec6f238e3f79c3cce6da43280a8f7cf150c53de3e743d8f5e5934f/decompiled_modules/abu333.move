module 0xdbec45dd47ec6f238e3f79c3cce6da43280a8f7cf150c53de3e743d8f5e5934f::abu333 {
    struct ABU333 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABU333, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABU333>(arg0, 9, b"ABU333", b"gjjgc ghjg", b"chf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99d74d9c-8e4c-4378-8464-dde37c4ab8bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABU333>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABU333>>(v1);
    }

    // decompiled from Move bytecode v6
}

