module 0xff638bed1077ef2345ed03ae446415677641b07e416a7444c27f955c07f33d5::polissya {
    struct POLISSYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLISSYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLISSYA>(arg0, 9, b"POLISSYA", b"Polissya", b"Fan token FC Polissya Zhytomyr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a38fc3fc-02ea-4843-8a4e-f4a6a958a6c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLISSYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLISSYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

