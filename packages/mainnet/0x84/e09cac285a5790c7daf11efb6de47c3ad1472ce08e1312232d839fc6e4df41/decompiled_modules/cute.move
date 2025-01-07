module 0x84e09cac285a5790c7daf11efb6de47c3ad1472ce08e1312232d839fc6e4df41::cute {
    struct CUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTE>(arg0, 9, b"CUTE", b"CUTES", b"Sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/107f09e1-596b-412c-9db6-909f86b56ef9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

