module 0x3c4ab17dd1df4ceb761dfabe39f60159c99d2983b7d6eb45a9a0acfc7b810bb0::paddy {
    struct PADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PADDY>(arg0, 6, b"PADDY", b"Paddy On Sui", b"Please peep, tell me for one reason why you like $PADDY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731691286548.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PADDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PADDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

