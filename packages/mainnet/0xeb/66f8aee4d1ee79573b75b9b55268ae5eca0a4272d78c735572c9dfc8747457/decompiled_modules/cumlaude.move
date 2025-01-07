module 0xeb66f8aee4d1ee79573b75b9b55268ae5eca0a4272d78c735572c9dfc8747457::cumlaude {
    struct CUMLAUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMLAUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMLAUDE>(arg0, 6, b"CumLaude", b"Cum Laude", x"43756d6d696e6720746f2064697372757074206d61726b65747320776974682068756d6f72202620696e73696768742e0a0a4669727374204149204167656e742064657369676e656420746f20616e616c797a6520616e642073756d6d6172697a6520737065636966696320746f70696373207769746820707265636973696f6e20616e6420637265617469766974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jlh_P_Tx_400x400_50e02f905e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMLAUDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMLAUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

