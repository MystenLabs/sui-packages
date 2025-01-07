module 0x48a7b9978a63723f239124e5a8aa80fda4c3362edb38691574212046b3f8f3cd::sp500 {
    struct SP500 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP500, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP500>(arg0, 6, b"SP500", b"Sui & Pussy 500", b"Sui & Pussy 500 outperform the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFP_8f377871a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP500>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP500>>(v1);
    }

    // decompiled from Move bytecode v6
}

