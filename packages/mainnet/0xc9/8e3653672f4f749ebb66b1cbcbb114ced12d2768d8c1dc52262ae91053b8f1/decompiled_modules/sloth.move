module 0xc98e3653672f4f749ebb66b1cbcbb114ced12d2768d8c1dc52262ae91053b8f1::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 9, b"SLOTH", b"Sloth coin", x"534c4f54482072656d696e647320757320746f2074616b65206c69666520736c6f772c20656e6a6f7920746865206a6f75726e65792c20616e6420656d6272616365207375737461696e61626c6520737563636573732e205065726665637420666f722074686f73652077686f2062656c6965766520696e20e2809c736c6f7720616e64207374656164792077696e732074686520726163652ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c36caf01-ab20-4e78-83eb-dd4ddcf0848f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

