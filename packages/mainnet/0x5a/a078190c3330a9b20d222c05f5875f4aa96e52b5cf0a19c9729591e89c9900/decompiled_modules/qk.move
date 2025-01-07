module 0x5aa078190c3330a9b20d222c05f5875f4aa96e52b5cf0a19c9729591e89c9900::qk {
    struct QK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QK>(arg0, 9, b"QK", b"Alaalak", b"Qp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/121e0538-2d50-4a70-b545-7118b953856e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QK>>(v1);
    }

    // decompiled from Move bytecode v6
}

