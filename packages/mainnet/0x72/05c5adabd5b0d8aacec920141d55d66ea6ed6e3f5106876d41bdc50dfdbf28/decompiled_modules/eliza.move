module 0x7205c5adabd5b0d8aacec920141d55d66ea6ed6e3f5106876d41bdc50dfdbf28::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"ELIZA", b"elizaOS by SuiAI", b"the operating system for ai agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2162_29a12857c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELIZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

