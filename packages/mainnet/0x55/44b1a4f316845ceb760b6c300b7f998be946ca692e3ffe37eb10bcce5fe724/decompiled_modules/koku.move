module 0x5544b1a4f316845ceb760b6c300b7f998be946ca692e3ffe37eb10bcce5fe724::koku {
    struct KOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKU>(arg0, 9, b"KOKU", b"Kokushki", b"Bergen svoi kokushki ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fe5a58e-63aa-4bd8-8631-e1ddfe3e89c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

