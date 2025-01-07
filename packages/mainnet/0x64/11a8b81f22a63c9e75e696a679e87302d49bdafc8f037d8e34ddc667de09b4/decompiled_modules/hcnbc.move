module 0x6411a8b81f22a63c9e75e696a679e87302d49bdafc8f037d8e34ddc667de09b4::hcnbc {
    struct HCNBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCNBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCNBC>(arg0, 9, b"HCNBC", b"cchxg", b"cxgjb ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0525e73a-c84e-462c-872a-1a0feb4f036f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCNBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCNBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

