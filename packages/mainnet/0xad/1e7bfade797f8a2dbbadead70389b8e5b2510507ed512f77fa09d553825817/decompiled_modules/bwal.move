module 0xad1e7bfade797f8a2dbbadead70389b8e5b2510507ed512f77fa09d553825817::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"BWAL", b"Blue Walrus", b"It`s sharp, memorable, animal-based, and feels crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5lnpqibajsl4vhgrb25whhkzncll3nclfy2k7u67bujtnwvpp54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

