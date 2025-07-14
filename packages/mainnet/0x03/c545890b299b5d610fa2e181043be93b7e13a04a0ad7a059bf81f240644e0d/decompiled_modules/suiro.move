module 0x3c545890b299b5d610fa2e181043be93b7e13a04a0ad7a059bf81f240644e0d::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 6, b"Suiro", b"suihero", b"Suihero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhfnmlntr5xjbsiq6a2vpc4cmdcdkgftxryte6mvqj2arv6w3hw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

