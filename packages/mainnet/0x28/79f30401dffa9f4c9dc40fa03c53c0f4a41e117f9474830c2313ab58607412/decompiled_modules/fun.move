module 0x2879f30401dffa9f4c9dc40fa03c53c0f4a41e117f9474830c2313ab58607412::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"fun", x"4c6967687420757020796f75722064617920776974682046756e436f696e3a2054686520706c617966756c2063727970746f63757272656e63792074686174277320616c6c2061626f7574206d616b696e672070726f6669747320656e6a6f7961626c652c2066696c6c696e6720796f757220706f7274666f6c696f207769746820636865657266756c206761696e7320616e64206120746f756368206f66207768696d737920f09f8e89", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/787acd8c-a71a-4bc5-9114-3afd8e7fb2c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

