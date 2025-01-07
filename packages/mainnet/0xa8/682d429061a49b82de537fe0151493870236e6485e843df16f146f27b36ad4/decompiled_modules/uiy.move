module 0xa8682d429061a49b82de537fe0151493870236e6485e843df16f146f27b36ad4::uiy {
    struct UIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIY>(arg0, 9, b"UIY", b"Wew", b"Token uiy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16aec357-6550-4495-8791-90a09166c833.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

