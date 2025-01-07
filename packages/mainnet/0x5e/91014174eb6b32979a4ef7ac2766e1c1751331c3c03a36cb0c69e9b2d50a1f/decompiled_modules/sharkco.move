module 0x5e91014174eb6b32979a4ef7ac2766e1c1751331c3c03a36cb0c69e9b2d50a1f::sharkco {
    struct SHARKCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKCO>(arg0, 9, b"SHARKCO", b"sharkbot", b"wewe trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75093f03-81be-48a4-8352-a54e314c0780.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

