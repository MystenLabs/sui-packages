module 0xeaf4290221aca1780d0d888be6e829b748a1cc1b1008ed0a1f5ab522d5afc3bd::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"RacHop", b"RacHopSui", b"With my bunny by my side, Rachop and I take the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956010557.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

