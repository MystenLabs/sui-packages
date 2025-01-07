module 0x5f14931634a5c23e745cf9885e7769d3d0e2f71c59f4ef9ce03cb175376c1dc1::suiseaa {
    struct SUISEAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEAA>(arg0, 6, b"SuiSeaa", b"SuiSea", b"Oceans have seas. In the sea there are millions of tons of water and millions of fish. Let's turn these fish into millionaires", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054279_b99fedadec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

