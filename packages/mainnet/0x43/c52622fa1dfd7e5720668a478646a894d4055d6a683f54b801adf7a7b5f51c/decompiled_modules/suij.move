module 0x43c52622fa1dfd7e5720668a478646a894d4055d6a683f54b801adf7a7b5f51c::suij {
    struct SUIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJ>(arg0, 6, b"SUIJ", b"SUI J", b"ah fuck, here we go again. SUI + GTA = bullish. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_J_e76b1b274d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

