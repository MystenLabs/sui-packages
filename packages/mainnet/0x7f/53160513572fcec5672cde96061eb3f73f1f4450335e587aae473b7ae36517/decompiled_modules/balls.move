module 0x7f53160513572fcec5672cde96061eb3f73f1f4450335e587aae473b7ae36517::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"Balls", b"Balls Tingling", b"Balls Tingling + SUI whales awakening + TurbosFun dumping + FUD levels over 9000 + FOMO reaching peak hopium + galaxy brain alignment + diamond balls + what if we all Lambo together + please SUI overlords, send it for the culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972529024.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

