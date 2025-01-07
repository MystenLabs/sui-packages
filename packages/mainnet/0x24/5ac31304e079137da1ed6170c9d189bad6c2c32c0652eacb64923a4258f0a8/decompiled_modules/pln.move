module 0x245ac31304e079137da1ed6170c9d189bad6c2c32c0652eacb64923a4258f0a8::pln {
    struct PLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLN>(arg0, 9, b"PLN", b"planet", b"Various planets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2395a74-9a9c-4db3-890e-afbbd430a8aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

