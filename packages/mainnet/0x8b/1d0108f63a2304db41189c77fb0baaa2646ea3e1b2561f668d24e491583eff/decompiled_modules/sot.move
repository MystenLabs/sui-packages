module 0x8b1d0108f63a2304db41189c77fb0baaa2646ea3e1b2561f668d24e491583eff::sot {
    struct SOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOT>(arg0, 6, b"SOT", b"sot", b"FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Stigmiotypo_othonis_12_0e2364e435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

