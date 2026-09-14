module 0xa80572a034f1cfcc31b37d7ba20efb966c357bd1da77d09f9a21a369da5feb12::suipop {
    struct SUIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOP>(arg0, 6, b"SUIPOP", b"Suipop", b"Token launchpad on Sui. Create, trade, graduate to Cetus or Turbos. Creators earn 60% of trading fees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/RGvn7emleXj9StoZiH-10XCufrFhamzfhtXw2DsUvHw")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPOP>>(0x2::coin::mint<SUIPOP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOP>>(v1);
    }

    // decompiled from Move bytecode v7
}

