module 0x47799fc057ba3dc8a199a9099685ffc450e1cf68e72f0ffaff4950d884de69a1::buckazoids {
    struct BUCKAZOIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKAZOIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKAZOIDS>(arg0, 9, b"Buckazoids", b"Buckazoids 1991", b"OG Bitcoin 1991", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPe58cRwSpwcAgs98aUyJYuVsiV3Ar4PrJ9Q45bYHmBP8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUCKAZOIDS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKAZOIDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKAZOIDS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

