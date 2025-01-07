module 0xc4fa074c518c47e8f4b7897c8998e137496b3800c526cf6944619f34ef6ba504::jg {
    struct JG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JG>(arg0, 9, b"JG", b"XC", b"VB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd264848-5130-4e4d-bc8b-0cf946e52dcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JG>>(v1);
    }

    // decompiled from Move bytecode v6
}

