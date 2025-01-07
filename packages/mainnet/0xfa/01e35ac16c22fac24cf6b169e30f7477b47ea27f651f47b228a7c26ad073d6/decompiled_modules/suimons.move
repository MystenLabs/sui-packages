module 0xfa01e35ac16c22fac24cf6b169e30f7477b47ea27f651f47b228a7c26ad073d6::suimons {
    struct SUIMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONS>(arg0, 6, b"SUIMONS", b"SuiMons", b"I am the king of the sea, the pump of the chart, the legend in your side", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimon_72c4c3875b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

