module 0xa6965729ae1be470e514b313c9b136a1533215a6a3efdf071ab3e44ca884c434::shrmpy {
    struct SHRMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRMPY>(arg0, 6, b"SHRMPY", b"Shrmpy", b"Meet the best genius $SHRMPY Shrimp on the sui network, Follow his adventure and become a $SHRMPY squad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073444_4d00c3efb1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

