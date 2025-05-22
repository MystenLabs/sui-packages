module 0x61260a6639667ad8ff4a9d493cf4bc9093ce6c1046c711c777161b9f3eae17db::snib {
    struct SNIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIB>(arg0, 6, b"SNIB", b"Snibbu", b"Snibbu snibbles its way to the smillies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicw5u5l2pglz5v5croaoja7ycw6x5ofz5qzrvzht236v3gevqxnha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

