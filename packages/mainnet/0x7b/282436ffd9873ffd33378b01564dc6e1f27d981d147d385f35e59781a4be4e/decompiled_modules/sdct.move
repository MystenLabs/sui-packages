module 0x7b282436ffd9873ffd33378b01564dc6e1f27d981d147d385f35e59781a4be4e::sdct {
    struct SDCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDCT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDCT>(arg0, 6, b"SDCT", b"SUI Addict by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dddd_bedd4e8235.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDCT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDCT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

