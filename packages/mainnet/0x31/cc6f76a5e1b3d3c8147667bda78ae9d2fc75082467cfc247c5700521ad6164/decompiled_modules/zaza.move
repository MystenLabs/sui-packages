module 0x31cc6f76a5e1b3d3c8147667bda78ae9d2fc75082467cfc247c5700521ad6164::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZAZA>(arg0, 6, b"ZAZA", b"zazacope", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $zaza + zazacope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/zaza-d2u7ia.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

