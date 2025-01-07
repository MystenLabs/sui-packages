module 0x4e0d8bd2e3b5b6da949c07c029d3f5da283cff407a00dc1d37410d3f3cc2480c::corgiai {
    struct CORGIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORGIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGIAI>(arg0, 6, b"CORGIAI", b"CorgiAI", b"CORGIAI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CORGIAI_d1361be9ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORGIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

