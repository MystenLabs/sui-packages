module 0x1bcb22f7c07f14ff952d885c177963a3c0b5420e2c9c6d702290fbf7ee9bf4b8::au {
    struct AU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AU>(arg0, 9, b"AU", b"Aurora", x"4175726f72612069732061206e6578742d67656e65726174696f6e2053554920636f6d70617469626c65204d454d4520626c6f636b636861696e20616e642065636f73797374656d20746861742072756e73206f6e2074686520737570706f727420616e64206c6f7665206f662074686520636f6d6d756e6974792e204a757374206c696b65206e6f72746865726e206175726f72612068617665206e6f206c696d6974732c206f757220636f6d6d756e6974792077696c6c2068617665206e6f206c696d69747320746f6f2e0a0a5765627369746520616e64205477697474657220636f6d696e6720736f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8105da1b-7479-4471-a6ce-d092a196be5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AU>>(v1);
    }

    // decompiled from Move bytecode v6
}

