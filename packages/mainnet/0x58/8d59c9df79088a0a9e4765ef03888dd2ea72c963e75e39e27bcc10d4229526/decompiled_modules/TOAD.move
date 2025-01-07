module 0x588d59c9df79088a0a9e4765ef03888dd2ea72c963e75e39e27bcc10d4229526::TOAD {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 8, b"TOAD", b"Sui Toad", b"TOAD TOAD TOAD TOAD TOAD TOAD TOAD TOAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmXkzF1TwEpQ91sCkBAe2tddVFYh946rBgSmQuen1KyssG?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOAD>>(0x2::coin::mint<TOAD>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOAD>>(v2);
    }

    // decompiled from Move bytecode v6
}

