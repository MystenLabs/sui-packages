module 0xb155c076d6f837d4a660c7877beb3755a9b881727e06a3b2a487d7ef8de8baf0::shiv {
    struct SHIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIV>(arg0, 9, b"SHIV", x"536869766120756ec3a0", b"Utility and tokenize asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35c2559f-404a-4d9c-bb44-608f5e0a3877.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

