module 0x134ef7775eb883b3119e2202324ae61a9bfca0bf599492fa3ffff39f3ca859d6::trcyborg {
    struct TRCYBORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCYBORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCYBORG>(arg0, 6, b"TRCYBORG", b"TRUMP CYBORG", b"TRUMP CYBORG WILL KILL EVERYONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRUMP_2_bea8cac373.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCYBORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRCYBORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

