module 0x3ca431fd3c71044ac83286e194a72e088828dc9afd1cfe5029b461437a3f0fca::bebra {
    struct BEBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBRA>(arg0, 9, b"BEBRA", b"bebra", b"Official Bebra Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95013578-f97c-4f82-8d9e-dec565a71745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

