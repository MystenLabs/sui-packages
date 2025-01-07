module 0xb7ca5098146f238dac77df07e58b10f27637ff160a55a4ebf70964ff5de18f41::spob {
    struct SPOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOB>(arg0, 6, b"SPOB", b"SpongeBob", x"2249276d207265616479212049276d2072656164792122202d53706f6e6765626f622d0a0a53756920436861696e20697320676f6f642c2053706f6e6765626f622073697474696e6720686572652e0a0a2068747470733a2f2f742e6d652f53706f6e6765626f625f7375690a2068747470733a2f2f782e636f6d2f53706f6e6765626f625f7375690a2068747470733a2f2f73706f6e6765626f622e706963732f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/268eceba3530ebd76ae65d40c418aacd_0724cb130b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

