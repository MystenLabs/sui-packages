module 0x2120950e2a0b648c6374aa77206e5cdf4f35841515bf30f762b51acfcb0bae2a::kene {
    struct KENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENE>(arg0, 9, b"KENE", b"dndn", b"kdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58754877-be2c-4b3b-96e1-e0de404ca558.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

