module 0x5e454613a9093b8bdec06a7733661f1a445372df7143ed221cdf8403a3bc1127::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"FLOPPY", b"Floppy Sui ", b"$FLOPPY the newest addition On  the  Turbos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987642290.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

