module 0x510445025c54ef0eff100a1cfd301b1e3c7990606e845f219e6024d4e363d90e::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"SmokinGoat", x"43617463682074686520686f7474657374206e657720636f696e206265666f726520697420676f65732031303030582e20446f6ee2809974206d697373206f75742e20476574206c6f6164656420776974682074686520536d6f6b696e20476f61742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ffa02a3-a790-4d2d-8061-35de005eb5c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

