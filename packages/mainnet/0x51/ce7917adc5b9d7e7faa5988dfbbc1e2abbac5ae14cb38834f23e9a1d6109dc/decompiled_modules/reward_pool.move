module 0x51ce7917adc5b9d7e7faa5988dfbbc1e2abbac5ae14cb38834f23e9a1d6109dc::reward_pool {
    struct RewardPool has key {
        id: 0x2::object::UID,
        admin: address,
        spark_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pulse_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        surge_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct YieldDeposited has copy, drop {
        gross_mist: u64,
        fee_mist: u64,
        spark_mist: u64,
        pulse_mist: u64,
        surge_mist: u64,
    }

    struct PrizeAwarded has copy, drop {
        pool: u8,
        winner: address,
        amount_mist: u64,
    }

    public fun award_pulse(arg0: &mut RewardPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pulse_pool) >= arg1, 1);
        let v0 = PrizeAwarded{
            pool        : 1,
            winner      : arg2,
            amount_mist : arg1,
        };
        0x2::event::emit<PrizeAwarded>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pulse_pool, arg1), arg3), arg2);
    }

    public fun award_spark(arg0: &mut RewardPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.spark_pool) >= arg1, 1);
        let v0 = PrizeAwarded{
            pool        : 0,
            winner      : arg2,
            amount_mist : arg1,
        };
        0x2::event::emit<PrizeAwarded>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.spark_pool, arg1), arg3), arg2);
    }

    public fun award_surge(arg0: &mut RewardPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.surge_pool) >= arg1, 1);
        let v0 = PrizeAwarded{
            pool        : 2,
            winner      : arg2,
            amount_mist : arg1,
        };
        0x2::event::emit<PrizeAwarded>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.surge_pool, arg1), arg3), arg2);
    }

    public fun deposit_yield(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0 * 200 / 10000;
        let v3 = v0 * 2000 / 10000;
        let v4 = v0 * 3000 / 10000;
        let v5 = v0 - v2 - v3 - v4;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg2), @0x1de8cef32b6324c2ade5659caa86db8e0dc3c1fd7a76dda17ff4c8de330f5f95);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.spark_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pulse_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.surge_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v5));
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v6 = YieldDeposited{
            gross_mist : v0,
            fee_mist   : v2,
            spark_mist : v3,
            pulse_mist : v4,
            surge_mist : v5,
        };
        0x2::event::emit<YieldDeposited>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = RewardPool{
            id         : 0x2::object::new(arg0),
            admin      : v0,
            spark_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            pulse_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            surge_pool : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RewardPool>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun pulse_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pulse_pool)
    }

    public fun spark_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.spark_pool)
    }

    public fun surge_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.surge_pool)
    }

    public fun treasury_balance(arg0: &RewardPool) : u64 {
        0
    }

    // decompiled from Move bytecode v7
}

