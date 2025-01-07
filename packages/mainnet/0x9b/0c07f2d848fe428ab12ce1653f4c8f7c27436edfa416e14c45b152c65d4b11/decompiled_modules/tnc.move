module 0x9b0c07f2d848fe428ab12ce1653f4c8f7c27436edfa416e14c45b152c65d4b11::tnc {
    struct TNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNC>(arg0, 9, b"TNC", b"TITANIC", x"546869732053756920546974616e696320697320556e73746f707061626c652120f09f9aa2f09f8c8a0a0a5765277265206e6f74206a757374206372756973696e67207468726f75676820746865206f6365616e206f6620537569e280947765277265206368617274696e67206120636f7572736520746f20756e636861727465642073686f726573206f662070726f7370657269747920616e642068617070696e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25d67811-5040-4c26-99c7-7ec75edb4e4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

