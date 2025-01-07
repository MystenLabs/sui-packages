module 0x6d62b669c2f9a8f45cc4766f01a12ed2f521918e4f9a8a57d6242080ecdcde9c::greatmusli {
    struct GREATMUSLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREATMUSLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREATMUSLI>(arg0, 9, b"GREATMUSLI", b"Ustad", b"To easy transaktion muslim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0068dd5-4962-4141-abaa-90f00fdff3b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREATMUSLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREATMUSLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

