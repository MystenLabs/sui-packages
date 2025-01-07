module 0x15c73d35eadfd0bc6a37996dc1cca044a61ee84a3e6bff4b62a17bea7d26f9af::pie {
    struct PIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIE>(arg0, 9, b"PIE", b"pie", x"496e64756c676520696e2070726f66697473207769746820506965436f696e3a205468652064656c6963696f75732063727970746f63757272656e6379207468617427732073657276696e67207570206120736c696365206f662066696e616e6369616c20737563636573732c2066696c6c696e6720796f757220706f7274666f6c696f2077697468207377656574206761696e7320616e642061207461737465206f662070726f7370657269747920f09fa5a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0d8f347-52fa-4995-8d40-c5b8806cf2ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

