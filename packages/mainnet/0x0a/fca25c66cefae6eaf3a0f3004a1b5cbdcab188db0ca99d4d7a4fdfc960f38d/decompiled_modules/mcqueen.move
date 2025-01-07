module 0xafca25c66cefae6eaf3a0f3004a1b5cbdcab188db0ca99d4d7a4fdfc960f38d::mcqueen {
    struct MCQUEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCQUEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCQUEEN>(arg0, 6, b"MCQUEEN", b"Mcqueen", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956010541.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCQUEEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCQUEEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

