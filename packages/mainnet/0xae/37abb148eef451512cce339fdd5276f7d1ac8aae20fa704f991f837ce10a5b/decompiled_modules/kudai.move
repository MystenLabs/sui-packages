module 0xae37abb148eef451512cce339fdd5276f7d1ac8aae20fa704f991f837ce10a5b::kudai {
    struct KUDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KUDAI>(arg0, 6, b"KUDAI", b"Kudai", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $Kudai + Kudai Agent https://t.co/Ln9IlRBqJi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kudai-2p5nrm.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KUDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

