module 0x1d5094c07ae5cadb214e73ca636fcd8448b5a9eb3f9241510a1baedabe0a2886::tpc {
    struct TPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPC>(arg0, 6, b"TPC", b"TrumpProCrypto ", b"Memecoin on Sui CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970667566.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

