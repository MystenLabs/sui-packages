module 0xd742cec6229c42c86a87c00d463dd490af68989d83379accf780844143da66c8::bullai {
    struct BULLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLAI>(arg0, 6, b"BULLAI", b"Bull Ai by SuiAI", b"bulishai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bullriun_3465526f64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

