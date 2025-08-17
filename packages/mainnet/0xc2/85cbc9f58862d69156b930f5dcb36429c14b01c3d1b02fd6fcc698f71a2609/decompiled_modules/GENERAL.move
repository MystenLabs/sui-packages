module 0xc285cbc9f58862d69156b930f5dcb36429c14b01c3d1b02fd6fcc698f71a2609::GENERAL {
    struct GENERAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENERAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENERAL>(arg0, 6, b"SUI GENERAL", b"GENERAL", x"54686520666561726c65737320636f6d6d616e646572206f662074686520535549207472656e636865732e204c656164696e672074686520646567656e2061726d792c2073616c7574696e67207468652053554920666c61672c20616e64206d61726368696e67207468726f756768206576657279206469702e20204e6f20736f6c6469657273206c65667420626568696e642e204e6f2072657472656174732e204f6e6c7920666f72776172642e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeifwzfeb42tmmk32ine6lrdzamcoewe4cc7thke5d3prpw4jzlq3fe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENERAL>>(v0, @0xdf931ed41d33f4fe6f1c8e23203495660d7e8f50d76c9c52d27fadb8834f8925);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENERAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

