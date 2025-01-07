module 0x88e7b93ccc5bae7d2a7f00711fc13b116a0a60dd0e1d080d215761587c840be1::lovely {
    struct LOVELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVELY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVELY>(arg0, 6, b"LOVELY", b"LOVELY on SUI", b"Little Love, Dream Big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731517836207.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVELY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVELY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

