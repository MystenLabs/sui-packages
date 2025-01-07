module 0x53abf1d4c1ab1478c60458e709a2555d8d2aaa4f28e8f4cffba9815f93f68cc::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"Andy", b"Andy Sui", b"Pepe's mischievous roommate has arrived on Sui, ready to make waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xdn_E_Bq_F5_400x400_d869408e3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

