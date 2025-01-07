module 0x59970e4677cae0ab71fc5bed2f731a24b23f150263615f9f2fe01366b21ee875::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC in SUI Now", x"436972636c6573205553444320737461626c65636f696e20746f206c61756e6368206f6e20537569206e6574776f726b0a546865205544534320737461626c65636f696e2077696c6c20736f6f6e206265636f6d65206e61746976656c7920737570706f72746564206f6e2074686520537569206e6574776f726b207468726f756768207468652043726f73732d436861696e205472616e736665722050726f746f636f6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0287_9e9e9686a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

