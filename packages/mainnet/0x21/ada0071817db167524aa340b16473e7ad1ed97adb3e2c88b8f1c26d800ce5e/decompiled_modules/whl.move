module 0x21ada0071817db167524aa340b16473e7ad1ed97adb3e2c88b8f1c26d800ce5e::whl {
    struct WHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHL>(arg0, 9, b"WHL", b"gear wheel", x"416363757261637920616e6420696e6e6f766174696f6e206f66206d656368616e6963616c20656e67696e656572696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4607b519-34a0-49a8-b347-9b2b2a34ac3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

