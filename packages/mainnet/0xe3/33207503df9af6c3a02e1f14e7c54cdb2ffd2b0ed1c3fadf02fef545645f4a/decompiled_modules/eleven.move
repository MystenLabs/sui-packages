module 0xe333207503df9af6c3a02e1f14e7c54cdb2ffd2b0ed1c3fadf02fef545645f4a::eleven {
    struct ELEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELEVEN>(arg0, 6, b"ELEVEN", b"THE ELEVEN by SuiAI", b"Developer by dynamic_11 complex.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/T_Yy9s1b6_400x400_6ec1caf396.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELEVEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEVEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

