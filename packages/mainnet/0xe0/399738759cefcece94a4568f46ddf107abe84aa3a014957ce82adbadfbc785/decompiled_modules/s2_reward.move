module 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::s2_reward {
    struct S2_REWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: S2_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S2_REWARD>(arg0, 9, b"S2_REWARD", b"Season 2 Reward", b"Fixed-supply accounting token for Current Season 2 liquidity mining rewards.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<S2_REWARD>>(0x2::coin::mint<S2_REWARD>(&mut v2, 46000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<S2_REWARD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S2_REWARD>>(v1);
    }

    public fun max_points() : u64 {
        46000000000000
    }

    // decompiled from Move bytecode v6
}

