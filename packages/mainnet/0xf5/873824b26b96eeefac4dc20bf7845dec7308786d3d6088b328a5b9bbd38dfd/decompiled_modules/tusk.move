module 0xf5873824b26b96eeefac4dc20bf7845dec7308786d3d6088b328a5b9bbd38dfd::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"TUSK", b"TUSK OFFICIAL", x"5455534b206973206120646563656e7472616c697a656420746f6b656e206c61756e6368706164206275696c74206f6e207468652053756920626c6f636b636861696e2c20656e61626c696e672063726561746f727320616e6420656e7472657072656e6575727320746f206465706c6f79206d656d6520636f696e73206f72207574696c69747920746f6b656e73206566666f72746c6573736c792e200a0a54686520466972737420546f6b656e204c61756e636870616420696e2057616c7275732050726f746f636f6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_28_001406_49d086b499.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

