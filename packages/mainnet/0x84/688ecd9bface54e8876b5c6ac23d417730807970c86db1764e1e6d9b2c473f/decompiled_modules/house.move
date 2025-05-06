module 0x84688ecd9bface54e8876b5c6ac23d417730807970c86db1764e1e6d9b2c473f::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSE>(arg0, 6, b"HOUSE", b"Housecoin Sui", b"Hedge against the housing market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia4ytsq474b53wih3zzea6di6qt4ghqlbuigqdxh4vzbi2n5chqai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

