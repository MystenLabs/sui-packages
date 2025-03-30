module 0x615b29e7cf458a4e29363a966a01d6a6bf5026349bb4e957daa61ca9ffff639d::up_wal {
    struct UP_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP_WAL>(arg0, 9, b"upWAL", b"DoubleUp Staked Walrus", b"DoubleUp Staked Walrus is the LST made for supporters, builders, and risk takers with no gambling required. Mixing fun, community, and utility while helping secure the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://doubleup-public.s3.us-east-1.amazonaws.com/walrus_lst/double_up_walrus_lst.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP_WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP_WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

