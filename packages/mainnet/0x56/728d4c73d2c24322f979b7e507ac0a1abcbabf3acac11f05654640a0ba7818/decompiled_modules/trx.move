module 0x56728d4c73d2c24322f979b7e507ac0a1abcbabf3acac11f05654640a0ba7818::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 6, b"USD", b"USD", b"USD is Us and  smile Dump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihuif2j2f54vi7j5a3qgu7gznfbmnegb2y4u4jdj3ftrhpiyzlbpy")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRX>>(0x2::coin::mint<TRX>(&mut v2, 30000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRX>>(v2);
    }

    // decompiled from Move bytecode v6
}

