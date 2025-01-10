module 0xd9c4567af43fa6a9d9400ee1047eef9cb52159bb24db7226bebc231e44ca61c1::sdct {
    struct SDCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDCT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDCT>(arg0, 6, b"SDCT", b"SUI ADDICT by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/reb_460cb1b71d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDCT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDCT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

