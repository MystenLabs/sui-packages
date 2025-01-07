module 0xc722dd04647d266855bf4c1cc76d3fb637892b426a234e0105ee226c6bfb411a::cz001 {
    struct CZ001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ001>(arg0, 9, b"CZ001", b"Cz Binance", x"466f7220746865206c6f7665206f662063727970746f2c20667574757265206f66206d6f6e657920616e642066726565646f6df09f8c8ef09f998c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3eed496d-5cdb-4055-b098-fc567432d679.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZ001>>(v1);
    }

    // decompiled from Move bytecode v6
}

