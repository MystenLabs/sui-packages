module 0xef0a1349d5bb6cc4fc36d8ffdcc51a9e937319564ef2a7b12c3152ce411138ff::koduck {
    struct KODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KODUCK>(arg0, 6, b"KODUCK", b"Koduck on Sui", x"4e6f626f64792067657473206974e280a6206275742065766572796f6e652077696e73212054686973206973204b6f6475636b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745912602156.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KODUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KODUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

