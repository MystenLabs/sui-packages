module 0x65fa3f94ba1947c18bcf6696d4e43d03df2664499642b5529d8b5b9f41ac27eb::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HopCat", b"HopCat", b"First cat on Hop Fun (@HopAggregator)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/QmUj5G11QzT8WGCFwxdxrJjYSjRPfqJy5ySmz3Kb9w2GrM")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOPCAT>>(0x2::coin::mint<HOPCAT>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOPCAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

