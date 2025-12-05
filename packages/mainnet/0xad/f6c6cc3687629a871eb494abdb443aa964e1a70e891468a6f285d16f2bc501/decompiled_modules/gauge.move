module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge {
    struct Deposit has copy, drop {
        account: address,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        account: address,
        amount: u64,
    }

    struct Harvest has copy, drop {
        account: address,
        reward: u64,
    }

    struct RewardAdded has copy, drop {
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Gauge<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        version: u8,
        reward_coins: 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>,
        staked_lp: 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>,
        duration: u64,
        period_finish: u64,
        reward_rate: u64,
        last_update_time: u64,
        reward_per_token_stored: u64,
        user_reward_per_token_paid: 0x2::table::Table<address, u64>,
        rewards: 0x2::table::Table<address, u64>,
        balances: 0x2::table::Table<address, u64>,
    }

    struct GaugeState has copy, drop {
        id: 0x2::object::ID,
        rewards: u64,
        total_supply: u64,
        period_finish: u64,
        reward_per_token: u64,
    }

    public fun id<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<Gauge<T0, T1, T2>>(arg0)
    }

    public fun notify_reward_amount<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x2::clock::Clock) {
        notify_reward_amount_<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun claim_fees<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg3: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        claim_fees_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun balance_of<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        }
    }

    fun claim_fees_<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg3: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let (v0, v1) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::claim_fees<T0, T1, T2>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::fee_vault_mut<T0, T1, T2>(arg1), arg6);
        let (v2, _) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::bribes_mut(arg3, id<T0, T1, T2>(arg0));
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::notify_reward_amount<T0>(v2, v0, arg2, arg4, arg5, arg6);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::notify_reward_amount<T1>(v2, v1, arg2, arg4, arg5, arg6);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: address, arg2: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>, arg3: &0x2::clock::Clock) {
        deposit_<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    fun deposit_<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: address, arg2: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        update_reward<T0, T1, T2>(arg0, 0x1::option::some<address>(arg1), arg3);
        if (!0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.balances, arg1, 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg2));
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.balances, arg1) = *0x2::table::borrow<address, u64>(&arg0.balances, arg1) + 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg2);
        };
        let v0 = Deposit{
            account : arg1,
            amount  : 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg2),
        };
        0x2::event::emit<Deposit>(v0);
        0x2::balance::join<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.staked_lp, 0x2::coin::into_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(arg2));
    }

    public fun earned<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        earned_<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun earned_<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&arg0.rewards, arg1)) {
            v1 = *0x2::table::borrow<address, u64>(&arg0.rewards, arg1);
        };
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.balances, arg1);
        };
        if (0x2::table::contains<address, u64>(&arg0.user_reward_per_token_paid, arg1)) {
            v2 = *0x2::table::borrow<address, u64>(&arg0.user_reward_per_token_paid, arg1);
        };
        v1 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v0, reward_per_token<T0, T1, T2>(arg0, arg2) - v2, 0x1::u64::pow(10, 9))
    }

    public fun get_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        get_reward_<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun get_reward_<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        assert!(arg0.version == 1, 0);
        update_reward<T0, T1, T2>(arg0, 0x1::option::some<address>(0x2::tx_context::sender(arg2)), arg1);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.rewards, 0x2::tx_context::sender(arg2));
        0x2::table::remove<address, u64>(&mut arg0.rewards, 0x2::tx_context::sender(arg2));
        let v1 = Harvest{
            account : 0x2::tx_context::sender(arg2),
            reward  : v0,
        };
        0x2::event::emit<Harvest>(v1);
        0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.reward_coins, v0), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_gauge<T0, T1, T2>(arg0: &mut 0x2::tx_context::TxContext) : Gauge<T0, T1, T2> {
        Gauge<T0, T1, T2>{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            reward_coins               : 0x2::balance::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(),
            staked_lp                  : 0x2::balance::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(),
            duration                   : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK(),
            period_finish              : 0,
            reward_rate                : 0,
            last_update_time           : 0,
            reward_per_token_stored    : 0,
            user_reward_per_token_paid : 0x2::table::new<address, u64>(arg0),
            rewards                    : 0x2::table::new<address, u64>(arg0),
            balances                   : 0x2::table::new<address, u64>(arg0),
        }
    }

    public fun last_time_reward_applicable<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        0x1::u64::min(0x2::clock::timestamp_ms(arg1), arg0.period_finish)
    }

    entry fun migrate<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906835531553046527);
        arg0.version = 1;
    }

    fun notify_reward_amount_<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        update_reward<T0, T1, T2>(arg0, 0x1::option::none<address>(), arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg0.period_finish) {
            arg0.reward_rate = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg1), 0x1::u64::pow(10, 9), arg0.duration);
        } else {
            arg0.reward_rate = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg1) + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg0.period_finish - v0, arg0.reward_rate, 0x1::u64::pow(10, 9)), 0x1::u64::pow(10, 9), arg0.duration);
        };
        let v1 = RewardAdded{reward: 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg1)};
        0x2::event::emit<RewardAdded>(v1);
        0x2::balance::join<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.reward_coins, 0x2::coin::into_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg1));
        assert!(arg0.reward_rate / 0x1::u64::pow(10, 9) <= 0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg0.reward_coins) / arg0.duration, 69);
        arg0.last_update_time = v0;
        arg0.period_finish = v0 + arg0.duration;
    }

    public fun reward_for_duration<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : u64 {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg0.reward_rate, arg0.duration, 0x1::u64::pow(10, 9))
    }

    public fun reward_per_token<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        reward_per_token_<T0, T1, T2>(arg0, arg1)
    }

    fun reward_per_token_<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg0.staked_lp) == 0) {
            arg0.reward_per_token_stored
        } else {
            arg0.reward_per_token_stored + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(last_time_reward_applicable<T0, T1, T2>(arg0, arg1) - arg0.last_update_time, arg0.reward_rate, 0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg0.staked_lp))
        }
    }

    public fun state<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock) : GaugeState {
        GaugeState{
            id               : id<T0, T1, T2>(arg0),
            rewards          : 0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg0.reward_coins),
            total_supply     : 0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&arg0.staked_lp),
            period_finish    : arg0.period_finish,
            reward_per_token : reward_per_token<T0, T1, T2>(arg0, arg1),
        }
    }

    fun update_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: 0x1::option::Option<address>, arg2: &0x2::clock::Clock) {
        arg0.reward_per_token_stored = reward_per_token<T0, T1, T2>(arg0, arg2);
        arg0.last_update_time = last_time_reward_applicable<T0, T1, T2>(arg0, arg2);
        if (0x1::option::is_some<address>(&arg1)) {
            let v0 = 0x1::option::destroy_some<address>(arg1);
            if (0x2::table::contains<address, u64>(&arg0.rewards, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.rewards, v0) = earned<T0, T1, T2>(arg0, v0, arg2);
            } else {
                0x2::table::add<address, u64>(&mut arg0.rewards, v0, earned<T0, T1, T2>(arg0, v0, arg2));
            };
            if (0x2::table::contains<address, u64>(&arg0.user_reward_per_token_paid, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.user_reward_per_token_paid, v0) = arg0.reward_per_token_stored;
            } else {
                0x2::table::add<address, u64>(&mut arg0.user_reward_per_token_paid, v0, arg0.reward_per_token_stored);
            };
        } else {
            0x1::option::destroy_none<address>(arg1);
        };
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>> {
        0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(withdraw_<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg3), arg1, arg2), arg3)
    }

    fun withdraw_<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>> {
        assert!(arg0.version == 1, 0);
        update_reward<T0, T1, T2>(arg0, 0x1::option::some<address>(arg1), arg3);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.balances, arg1) = *0x2::table::borrow<address, u64>(&arg0.balances, arg1) - arg2;
        let v0 = Withdraw{
            account : arg1,
            amount  : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
        0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.staked_lp, arg2)
    }

    public fun withdraw_all<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>> {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>(withdraw_<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg2), v0, arg1), arg2)
    }

    public fun withdraw_all_and_harvest<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::PoolLiquidityCoin<T0, T1, T2>>, 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>) {
        let v0 = withdraw_all<T0, T1, T2>(arg0, arg1, arg2);
        (v0, get_reward<T0, T1, T2>(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

