module 0x9fc09c4cb38f3feb1a1212bb3d04bbc3c20accda18fea4cce2d5493515aeeebb::bluedoge {
    struct BLUEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOGE>(arg0, 6, b"BlueDoge", b"BLUEDOGE", x"446f67652c20627574206f6e205355492c207468617420697320746f20736179206265747465722120546f7563682074686520736b7920776974682074686520626c75652024646f67652c206f6e6c79206f6e207468652053554920636861696e2e205768657265206d656d6573206d6565742074686520426c7565206d6f6f6e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_com_optimize_8ba6ca3947.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

