module 0x9086233ed6098de0b3b56f536ebe4e18f4967a0ed6f37cc669047099bdfa1a8e::niulai {
    struct NIULAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIULAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIULAI>(arg0, 6, b"NIULAI", x"e7899be69da5", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/R7FfgoVfwKWM-kz4LzzfV93WBHXkqM-xuq8a3_XVzFk")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NIULAI>>(0x2::coin::mint<NIULAI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIULAI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIULAI>>(v1);
    }

    // decompiled from Move bytecode v7
}

