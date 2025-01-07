module 0x1e52fec740ebe5dc28cf9d09858ef9480a6289b4a8f0e2a67fcd90e2ec5d70ad::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 9, b"SSS", b"starfish", x"5368696e65206272696768746c792077697468205374617266697368436f696e3a205468652072616469616e742063727970746f63757272656e637920746861742773206d616b696e6720776176657320696e207468652063727970746f206f6365616e2c206272696e67696e67207374656c6c61722070726f6669747320616e64207374617272792d6579656420647265616d7320746f20796f757220706f7274666f6c696f20f09f8c9ff09f8c9ff09f8c9ff09f8c9ff09f8c9ff09f8c9ff09f8c9ff09f8c9ff09f8c9f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93ccbdbf-f450-424e-aee0-9c7b75519e47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

