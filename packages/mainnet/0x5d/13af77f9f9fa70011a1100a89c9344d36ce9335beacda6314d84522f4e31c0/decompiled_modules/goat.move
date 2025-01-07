module 0x5d13af77f9f9fa70011a1100a89c9344d36ce9335beacda6314d84522f4e31c0::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"SmokinGoat", x"43617463682074686520686f7474657374206e657720636f696e206265666f726520697420676f65732031303030582e20446f6ee2809974206d697373206f75742e20476574206c6f6164656420776974682074686520536d6f6b696e20476f61742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dd04ba2-eae4-47d1-af99-503353481ba0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

