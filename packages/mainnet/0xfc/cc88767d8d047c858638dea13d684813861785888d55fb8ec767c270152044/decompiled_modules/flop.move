module 0xfccc88767d8d047c858638dea13d684813861785888d55fb8ec767c270152044::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 9, b"FLOP                              ", b"Flop                                                              ", b"More than just a seal.                                                                                                                                                                                                                                                                                                                                                                                                                                                ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flopfun.com/icon/1763db2d-39f1-43af-abdc-d59f14f956ee.png                                                                                                                                                   ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

