module 0x4d2bcfa66616b5bb89cf0aa7ecf568c5941c2af0c6a1dff01fec9452061f0ddd::dogue {
    struct DOGUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGUE>(arg0, 6, b"DOGUE", b"Dog Tongue", x"444f4720544f4e475545206973206e6f206f7264696e61727920646f672c206375746520627574207374726f6e672c20696e74656c6c6967656e7420616e640a70657273697374656e742c20686520726f616d7320746865207661737420706c61696e732077697468206e6f626c6520676f616c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3yojcywzzzo2oprymzkb5wmb3jtb3ukyqs5l2ut7jo2no2usohi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

