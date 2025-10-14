module 0xa279c02449e330ac2ca05ddbf04a1b9c7e9e8cd4eeab1df0a7ca51213051dbc::suiboo {
    struct SUIBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOO>(arg0, 9, b"SUIBOO", b"Sui Combo", b"This is a SUI maxi strategy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/lx9wxqY2gquXEqqcqZWhh-GezN7YGzpWZmdgXiQ3PnA")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUIBOO>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

