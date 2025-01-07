module 0x7f67d751fb7586aa40db05d30bf9647fb12b964f2b6f67777be463906f92faef::tinkle {
    struct TINKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKLE>(arg0, 6, b"TINKLE", b"TINKLEWOSS", x"54696e6b6c65202d2054686520275065706527206f662074686520576174657220436861696e0a0a54696e6b6c65206973206d616b696e67206974207261696e206f6e207468652053756920426c6f636b636861696e210a0a54696e6b6c6520696e207468652073686f7765722e2054696e6b6c65206f6e2074686520666c6f6f722e2054696e6b6c652065766572797768657265210a0a546865205265766f6c7574696f6e206f66205375692073746172747320776974682054696e6b6c6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0e010e0wawz_7941f12b9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

