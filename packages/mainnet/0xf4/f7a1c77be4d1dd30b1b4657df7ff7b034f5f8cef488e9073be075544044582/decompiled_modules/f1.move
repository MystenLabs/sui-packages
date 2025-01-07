module 0xf4f7a1c77be4d1dd30b1b4657df7ff7b034f5f8cef488e9073be075544044582::f1 {
    struct F1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F1>(arg0, 9, b"F1", b"F1 token", b"F1 for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/400b8422-f6c9-44ee-baaa-e28520e1bcbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F1>>(v1);
    }

    // decompiled from Move bytecode v6
}

