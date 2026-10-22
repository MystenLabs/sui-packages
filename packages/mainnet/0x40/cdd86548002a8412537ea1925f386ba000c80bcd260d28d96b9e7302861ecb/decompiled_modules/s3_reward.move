module 0x40cdd86548002a8412537ea1925f386ba000c80bcd260d28d96b9e7302861ecb::s3_reward {
    struct S3_REWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: S3_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S3_REWARD>(arg0, 9, b"S3_REWARD", b"Season 3 Reward", b"Fixed-supply accounting token for Current Season 3 liquidity mining rewards.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<S3_REWARD>>(0x2::coin::mint<S3_REWARD>(&mut v2, 86100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<S3_REWARD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S3_REWARD>>(v1);
    }

    public fun max_points() : u64 {
        86100000000000
    }

    // decompiled from Move bytecode v6
}

