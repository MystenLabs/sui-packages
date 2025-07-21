module 0xe2d0c1cc067d19a0f682d754fae6e63bb9d19b088410d47eac0fb5088310aafd::tengri {
    struct TENGRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENGRI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TENGRI>(arg0, 6, b"TENGRI", b"Tengri", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $TENGRI + Tengri https://t.co/yrBER9ph4K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tengri-cb34ne.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENGRI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENGRI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

