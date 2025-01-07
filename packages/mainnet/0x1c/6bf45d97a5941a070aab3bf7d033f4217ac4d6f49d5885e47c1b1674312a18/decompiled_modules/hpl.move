module 0x1c6bf45d97a5941a070aab3bf7d033f4217ac4d6f49d5885e47c1b1674312a18::hpl {
    struct HPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPL>(arg0, 9, b"HPL", b"Helpcoin", b"Help poors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6597986c-eb82-4258-b8de-8aabeef0fb2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

