module 0xbb57811a726915aaeb008a67a66c89e4ea250d4e3195ffd17a06445744a5a6c9::sim {
    struct SIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIM>(arg0, 9, b"SIM", b"Simpson", x"46726f6d20636f726f6e61766972757320746f204c6164792047616761277320537570657220426f776c20706572666f726d616e636520746f20746865204170706c6520566973696f6e2050726f2c205468652053696d70736f6e73207365656d20746f2068617665207072656469637465642065766572797468696e6720696e206f757220667574757265210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0476e8be-adb0-4ce1-9158-28df7cb27c1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

