module 0x86530a6e5885f0df829dc1a801b10fc84e218334c8b975332d46baf51ba0b91c::pvdan {
    struct PVDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PVDAN>(arg0, 6, b"PVDAN", b"PVDan by SuiAI", b"PVDan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1664525936525_81148b513d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PVDAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVDAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

