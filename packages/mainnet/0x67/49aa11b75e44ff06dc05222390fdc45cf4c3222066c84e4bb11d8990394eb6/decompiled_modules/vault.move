module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::vault {
    struct DUSDC has drop {
        dummy_field: bool,
    }

    struct StrategyRatio has copy, drop, store {
        yield_bps: u64,
        predict_range_bps: u64,
        plp_bps: u64,
        reserve_bps: u64,
    }

    struct VaultConfig<phantom T0> has key {
        id: 0x2::object::UID,
        total_deposits: u64,
        total_shares: u64,
        total_invested: u64,
        total_yield_earned: u64,
        strategy: StrategyRatio,
        drip_interval_ms: u64,
        min_deposit: u64,
        max_deposit: u64,
        yield_pool: 0x2::balance::Balance<T0>,
        predict_pool: 0x2::balance::Balance<T0>,
        reserve_pool: 0x2::balance::Balance<T0>,
        paused: bool,
        admin: address,
        plan_count: u64,
    }

    struct UserPlan<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        vault_id: 0x2::object::ID,
        total_deposited: u64,
        amount_per_round: u64,
        total_rounds: u64,
        rounds_completed: u64,
        idle_balance: 0x2::balance::Balance<T0>,
        invested_value: u64,
        yield_earned: u64,
        created_at: u64,
        last_drip_at: u64,
        drip_interval_ms: u64,
        strategy: StrategyRatio,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        strategy: StrategyRatio,
    }

    struct PlanCreated has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        total_deposited: u64,
        amount_per_round: u64,
        total_rounds: u64,
        strategy: StrategyRatio,
    }

    struct DripExecuted has copy, drop {
        plan_id: 0x2::object::ID,
        round: u64,
        amount: u64,
        timestamp: u64,
    }

    struct Withdrawal has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        shares_burned: u64,
    }

    struct TopUp has copy, drop {
        plan_id: 0x2::object::ID,
        amount: u64,
        new_total: u64,
    }

    struct Compounded has copy, drop {
        vault_id: 0x2::object::ID,
        yield_amount: u64,
        timestamp: u64,
    }

    struct Redeemed has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    public entry fun create_plan<T0>(arg0: &mut VaultConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.strategy;
        create_plan_internal<T0>(arg0, arg1, arg2, arg3, v0, arg4, arg5);
    }

    fun create_plan_internal<T0>(arg0: &mut VaultConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: StrategyRatio, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 100);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.min_deposit, 101);
        assert!(v0 <= arg0.max_deposit, 102);
        assert!(arg2 > 0 && arg3 > 0, 103);
        assert!(arg2 * arg3 <= v0, 103);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3) = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token::mint(0x2::object::id<VaultConfig<T0>>(arg0), v0, arg0.total_deposits + arg0.total_yield_earned, arg0.total_shares, v1, arg6);
        arg0.total_deposits = arg0.total_deposits + v0;
        arg0.total_shares = arg0.total_shares + v3;
        arg0.plan_count = arg0.plan_count + 1;
        let v4 = UserPlan<T0>{
            id               : 0x2::object::new(arg6),
            owner            : 0x2::tx_context::sender(arg6),
            vault_id         : 0x2::object::id<VaultConfig<T0>>(arg0),
            total_deposited  : v0,
            amount_per_round : arg2,
            total_rounds     : arg3,
            rounds_completed : 0,
            idle_balance     : 0x2::coin::into_balance<T0>(arg1),
            invested_value   : 0,
            yield_earned     : 0,
            created_at       : v1,
            last_drip_at     : v1,
            drip_interval_ms : arg0.drip_interval_ms,
            strategy         : arg4,
        };
        let v5 = PlanCreated{
            plan_id          : 0x2::object::id<UserPlan<T0>>(&v4),
            owner            : 0x2::tx_context::sender(arg6),
            total_deposited  : v0,
            amount_per_round : arg2,
            total_rounds     : arg3,
            strategy         : arg4,
        };
        0x2::event::emit<PlanCreated>(v5);
        0x2::transfer::share_object<UserPlan<T0>>(v4);
        0x2::transfer::public_transfer<0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token::ShareToken>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun create_plan_with_strategy<T0>(arg0: &mut VaultConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 + arg5 + arg6 + arg7 == 10000, 107);
        let v0 = StrategyRatio{
            yield_bps         : arg4,
            predict_range_bps : arg5,
            plp_bps           : arg6,
            reserve_bps       : arg7,
        };
        create_plan_internal<T0>(arg0, arg1, arg2, arg3, v0, arg8, arg9);
    }

    public entry fun create_vault<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 + arg4 + arg5 + arg6 == 10000, 107);
        let v0 = StrategyRatio{
            yield_bps         : arg3,
            predict_range_bps : arg4,
            plp_bps           : arg5,
            reserve_bps       : arg6,
        };
        let v1 = VaultConfig<T0>{
            id                 : 0x2::object::new(arg7),
            total_deposits     : 0,
            total_shares       : 0,
            total_invested     : 0,
            total_yield_earned : 0,
            strategy           : v0,
            drip_interval_ms   : arg2,
            min_deposit        : arg0,
            max_deposit        : arg1,
            yield_pool         : 0x2::balance::zero<T0>(),
            predict_pool       : 0x2::balance::zero<T0>(),
            reserve_pool       : 0x2::balance::zero<T0>(),
            paused             : false,
            admin              : 0x2::tx_context::sender(arg7),
            plan_count         : 0,
        };
        let v2 = VaultCreated{
            vault_id : 0x2::object::id<VaultConfig<T0>>(&v1),
            admin    : 0x2::tx_context::sender(arg7),
            strategy : v0,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<VaultConfig<T0>>(v1);
    }

    public fun deploy_idle<T0>(arg0: &mut VaultConfig<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg2 > 0, 108);
        let v0 = if (arg1 == 0) {
            &mut arg0.yield_pool
        } else {
            assert!(arg1 == 1, 110);
            &mut arg0.predict_pool
        };
        assert!(0x2::balance::value<T0>(v0) >= arg2, 106);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    public entry fun drip_invest<T0>(arg0: &mut VaultConfig<T0>, arg1: &mut UserPlan<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.paused, 100);
        assert!(arg1.rounds_completed < arg1.total_rounds, 105);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_drip_at + arg1.drip_interval_ms, 104);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(arg1.amount_per_round, 0x2::balance::value<T0>(&arg1.idle_balance));
        assert!(v1 > 0, 106);
        let v2 = 0x2::balance::split<T0>(&mut arg1.idle_balance, v1);
        let v3 = &arg1.strategy;
        let v4 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v1, v3.yield_bps);
        let v5 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v1, v3.predict_range_bps + v3.plp_bps);
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.yield_pool, 0x2::balance::split<T0>(&mut v2, v4));
        };
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut arg0.predict_pool, 0x2::balance::split<T0>(&mut v2, v5));
        };
        0x2::balance::join<T0>(&mut arg0.reserve_pool, v2);
        arg1.rounds_completed = arg1.rounds_completed + 1;
        arg1.last_drip_at = v0;
        arg1.invested_value = arg1.invested_value + v1;
        arg0.total_invested = arg0.total_invested + v1;
        let v6 = DripExecuted{
            plan_id   : 0x2::object::id<UserPlan<T0>>(arg1),
            round     : arg1.rounds_completed,
            amount    : v1,
            timestamp : v0,
        };
        0x2::event::emit<DripExecuted>(v6);
    }

    public entry fun pause<T0>(arg0: &mut VaultConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.paused = true;
    }

    public fun plan_idle_balance<T0>(arg0: &UserPlan<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_balance)
    }

    public fun plan_invested_value<T0>(arg0: &UserPlan<T0>) : u64 {
        arg0.invested_value
    }

    public fun plan_is_complete<T0>(arg0: &UserPlan<T0>) : bool {
        arg0.rounds_completed >= arg0.total_rounds
    }

    public fun plan_next_drip_at<T0>(arg0: &UserPlan<T0>) : u64 {
        arg0.last_drip_at + arg0.drip_interval_ms
    }

    public fun plan_owner<T0>(arg0: &UserPlan<T0>) : address {
        arg0.owner
    }

    public fun plan_rounds_completed<T0>(arg0: &UserPlan<T0>) : u64 {
        arg0.rounds_completed
    }

    public fun plan_strategy_bps<T0>(arg0: &UserPlan<T0>) : (u64, u64, u64, u64) {
        let v0 = &arg0.strategy;
        (v0.yield_bps, v0.predict_range_bps, v0.plp_bps, v0.reserve_bps)
    }

    public fun plan_total_rounds<T0>(arg0: &UserPlan<T0>) : u64 {
        arg0.total_rounds
    }

    public fun plan_total_value<T0>(arg0: &UserPlan<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_balance) + arg0.invested_value + arg0.yield_earned
    }

    public fun plan_yield_earned<T0>(arg0: &UserPlan<T0>) : u64 {
        arg0.yield_earned
    }

    public entry fun record_compound<T0>(arg0: &mut VaultConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 108);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v0, arg0.strategy.reserve_bps);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.reserve_pool, 0x2::balance::split<T0>(&mut v2, v1));
        };
        let v3 = &arg0.strategy;
        let v4 = v3.yield_bps + v3.predict_range_bps + v3.plp_bps;
        if (v4 == 0) {
            0x2::balance::join<T0>(&mut arg0.reserve_pool, v2);
        } else {
            let v5 = (((0x2::balance::value<T0>(&v2) as u128) * (v3.yield_bps as u128) / (v4 as u128)) as u64);
            if (v5 > 0) {
                0x2::balance::join<T0>(&mut arg0.yield_pool, 0x2::balance::split<T0>(&mut v2, v5));
            };
            0x2::balance::join<T0>(&mut arg0.predict_pool, v2);
        };
        arg0.total_yield_earned = arg0.total_yield_earned + v0;
        let v6 = Compounded{
            vault_id     : 0x2::object::id<VaultConfig<T0>>(arg0),
            yield_amount : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Compounded>(v6);
    }

    public entry fun record_redeem<T0>(arg0: &mut VaultConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 108);
        0x2::balance::join<T0>(&mut arg0.reserve_pool, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Redeemed{
            vault_id  : 0x2::object::id<VaultConfig<T0>>(arg0),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Redeemed>(v1);
    }

    public entry fun top_up<T0>(arg0: &mut VaultConfig<T0>, arg1: &mut UserPlan<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 100);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 109);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 108);
        0x2::balance::join<T0>(&mut arg1.idle_balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.total_deposited = arg1.total_deposited + v0;
        arg0.total_deposits = arg0.total_deposits + v0;
        let v1 = TopUp{
            plan_id   : 0x2::object::id<UserPlan<T0>>(arg1),
            amount    : v0,
            new_total : arg1.total_deposited,
        };
        0x2::event::emit<TopUp>(v1);
    }

    public entry fun unpause<T0>(arg0: &mut VaultConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.paused = false;
    }

    public entry fun update_strategy<T0>(arg0: &mut VaultConfig<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        assert!(arg1 + arg2 + arg3 + arg4 == 10000, 107);
        let v0 = StrategyRatio{
            yield_bps         : arg1,
            predict_range_bps : arg2,
            plp_bps           : arg3,
            reserve_bps       : arg4,
        };
        arg0.strategy = v0;
    }

    public fun vault_idle_balance<T0>(arg0: &VaultConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yield_pool) + 0x2::balance::value<T0>(&arg0.predict_pool)
    }

    public fun vault_is_paused<T0>(arg0: &VaultConfig<T0>) : bool {
        arg0.paused
    }

    public fun vault_plan_count<T0>(arg0: &VaultConfig<T0>) : u64 {
        arg0.plan_count
    }

    public fun vault_predict_pool_balance<T0>(arg0: &VaultConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.predict_pool)
    }

    public fun vault_reserve_balance<T0>(arg0: &VaultConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_pool)
    }

    public fun vault_total_deposits<T0>(arg0: &VaultConfig<T0>) : u64 {
        arg0.total_deposits
    }

    public fun vault_total_invested<T0>(arg0: &VaultConfig<T0>) : u64 {
        arg0.total_invested
    }

    public fun vault_total_shares<T0>(arg0: &VaultConfig<T0>) : u64 {
        arg0.total_shares
    }

    public fun vault_total_yield<T0>(arg0: &VaultConfig<T0>) : u64 {
        arg0.total_yield_earned
    }

    public fun vault_yield_pool_balance<T0>(arg0: &VaultConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yield_pool)
    }

    public entry fun withdraw<T0>(arg0: &mut VaultConfig<T0>, arg1: &mut UserPlan<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 109);
        let v0 = withdraw_internal<T0>(arg0, arg1, arg2);
        let v1 = Withdrawal{
            plan_id       : 0x2::object::id<UserPlan<T0>>(arg1),
            owner         : arg1.owner,
            amount        : 0x2::balance::value<T0>(&v0),
            shares_burned : 0,
        };
        0x2::event::emit<Withdrawal>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdraw_all_and_burn<T0>(arg0: &mut VaultConfig<T0>, arg1: &mut UserPlan<T0>, arg2: 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token::ShareToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 109);
        let v0 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token::shares(&arg2);
        0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token::burn(arg2, arg0.total_deposits + arg0.total_yield_earned, arg0.total_shares);
        arg0.total_shares = arg0.total_shares - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(v0, arg0.total_shares);
        let v1 = 0x2::balance::value<T0>(&arg1.idle_balance) + arg1.invested_value;
        let v2 = withdraw_internal<T0>(arg0, arg1, v1);
        let v3 = Withdrawal{
            plan_id       : 0x2::object::id<UserPlan<T0>>(arg1),
            owner         : arg1.owner,
            amount        : 0x2::balance::value<T0>(&v2),
            shares_burned : v0,
        };
        0x2::event::emit<Withdrawal>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), 0x2::tx_context::sender(arg4));
    }

    fun withdraw_internal<T0>(arg0: &mut VaultConfig<T0>, arg1: &mut UserPlan<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(arg2, 0x2::balance::value<T0>(&arg1.idle_balance));
        let v1 = 0x2::balance::zero<T0>();
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg1.idle_balance, v0));
        };
        let v2 = arg2 - v0;
        if (v2 > 0) {
            let v3 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(v2, arg1.invested_value), 0x2::balance::value<T0>(&arg0.reserve_pool));
            if (v3 > 0) {
                0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.reserve_pool, v3));
                arg1.invested_value = arg1.invested_value - v3;
                arg0.total_invested = arg0.total_invested - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(v3, arg0.total_invested);
            };
        };
        assert!(0x2::balance::value<T0>(&v1) > 0, 108);
        v1
    }

    // decompiled from Move bytecode v7
}

