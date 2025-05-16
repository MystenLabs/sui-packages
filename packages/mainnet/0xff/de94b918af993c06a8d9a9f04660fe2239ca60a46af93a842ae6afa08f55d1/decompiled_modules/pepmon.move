module 0xffde94b918af993c06a8d9a9f04660fe2239ca60a46af93a842ae6afa08f55d1::pepmon {
    struct PEPMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPMON>(arg0, 6, b"PEPMON", b"PEPEMON", b"pepemonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcsd6s757lkr4is66wjyz5jujmlt5hzhfo2776bngjzx2yszfvxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

