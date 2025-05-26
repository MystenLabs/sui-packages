module 0xd14393c42ff76069c7a2eed5da6a4b4c1654914031e192e725813103f2b4d597::btcm {
    struct BTCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCM>(arg0, 6, b"BTCM", b"Back To McDonalds", b"Time to prove them wrong.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mcdonal_ca852cfa81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

