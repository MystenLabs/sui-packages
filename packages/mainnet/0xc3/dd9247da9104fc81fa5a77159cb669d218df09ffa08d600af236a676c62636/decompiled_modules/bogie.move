module 0xc3dd9247da9104fc81fa5a77159cb669d218df09ffa08d600af236a676c62636::bogie {
    struct BOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGIE>(arg0, 6, b"BOGIE", b"Bogie Sui", b"No roadmap, No boss, Only vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibqvj6wf2bimmioacsueo6wwn2vy3uc4hyeszsmsiv4rliew6qd5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOGIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

