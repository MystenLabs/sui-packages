module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker {
    struct SuidoubleLiquidStaker has store {
        staked_pool: vector<0x3::staking_pool::StakedSui>,
        staked_amount: u64,
    }

    struct RebalanceEvent has copy, drop {
        unstaked_count: u64,
        restaked_amount: u64,
        to_pending_amount: u64,
    }

    public(friend) fun default() : SuidoubleLiquidStaker {
        SuidoubleLiquidStaker{
            staked_pool   : 0x1::vector::empty<0x3::staking_pool::StakedSui>(),
            staked_amount : 0,
        }
    }

    fun epoch_staked_sui_growth_rates(arg0: &mut SuidoubleLiquidStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 5;
        let v3 = 1000000000;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool)) {
            let v4 = 0x3::staking_pool::pool_id(0x1::vector::borrow<0x3::staking_pool::StakedSui>(&arg0.staked_pool, v0));
            let v5 = 0x3::sui_system::pool_exchange_rates(arg1, &v4);
            let v6 = staking_pool_echange_rate_at_epoch(v5, arg2);
            let v7 = 0;
            if (arg2 >= v2) {
                v7 = arg2 - v2;
            };
            let v8 = staking_pool_echange_rate_at_epoch(v5, v7);
            let v9 = 0x3::staking_pool::pool_token_amount(&v6);
            if (v9 == 0) {
                0x1::vector::push_back<u128>(&mut v1, 0);
            } else {
                let v10 = 0x3::staking_pool::pool_token_amount(&v8);
                if (v10 == 0) {
                    0x1::vector::push_back<u128>(&mut v1, 0);
                } else {
                    let v11 = (0x3::staking_pool::sui_amount(&v6) as u128) * (v3 as u128) / (v9 as u128);
                    let v12 = (0x3::staking_pool::sui_amount(&v8) as u128) * (v3 as u128) / (v10 as u128);
                    if (v12 >= v11) {
                        0x1::vector::push_back<u128>(&mut v1, 0);
                    } else {
                        0x1::vector::push_back<u128>(&mut v1, v11 - v12);
                    };
                };
            };
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun expected_available_staked_balance(arg0: &vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            let v2 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v0);
            if (0x3::staking_pool::stake_activation_epoch(v2) <= arg2) {
                v1 = v1 + expected_staked_balance_of(v2, arg1, arg2);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun expected_staked_balance(arg0: &vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            v1 = v1 + expected_staked_balance_of(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v0), arg1, arg2);
            v0 = v0 + 1;
        };
        v1
    }

    fun expected_staked_balance_of(arg0: &0x3::staking_pool::StakedSui, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) : u64 {
        let v0 = 0x3::staking_pool::stake_activation_epoch(arg0);
        if (v0 >= arg2) {
            return 0x3::staking_pool::staked_sui_amount(arg0)
        };
        let v1 = 0x3::staking_pool::pool_id(arg0);
        let v2 = 0x3::sui_system::pool_exchange_rates(arg1, &v1);
        let v3 = staking_pool_echange_rate_at_epoch(v2, v0);
        let v4 = staking_pool_echange_rate_at_epoch(v2, arg2);
        get_sui_amount(&v4, get_token_amount(&v3, 0x3::staking_pool::staked_sui_amount(arg0)))
    }

    public(friend) fun find_the_perfect_staked_sui(arg0: &mut SuidoubleLiquidStaker, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x3::staking_pool::StakedSui> {
        if (arg1 < 1000000000) {
            return 0x1::option::none<0x3::staking_pool::StakedSui>()
        };
        let v0 = 0;
        let v1 = 0x2::tx_context::epoch(arg3);
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool)) {
            let v2 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(&arg0.staked_pool, v0);
            if (0x3::staking_pool::stake_activation_epoch(v2) <= v1) {
                let v3 = 0x3::staking_pool::staked_sui_amount(v2);
                let v4 = expected_staked_balance_of(v2, arg2, v1);
                if (v4 >= arg1) {
                    let v5 = (arg1 as u128) * (v3 as u128) / (v4 as u128);
                    if ((v5 as u64) < v3 - 1000000000 && (v5 as u64) >= 1000000000) {
                        arg0.staked_amount = arg0.staked_amount - (v5 as u64);
                        return 0x1::option::some<0x3::staking_pool::StakedSui>(0x3::staking_pool::split(0x1::vector::borrow_mut<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, v0), (v5 as u64), arg3))
                    };
                };
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x3::staking_pool::StakedSui>()
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        let v0 = 0x3::staking_pool::sui_amount(arg0);
        let v1 = 0x3::staking_pool::pool_token_amount(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v0 as u128) * (arg1 as u128) / (v1 as u128)) as u64)
    }

    fun get_token_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        let v0 = 0x3::staking_pool::sui_amount(arg0);
        let v1 = 0x3::staking_pool::pool_token_amount(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    fun partion(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut vector<u128>, arg2: u64, arg3: u64) : u64 {
        let v0 = arg2 + 1;
        let v1 = v0;
        while (v0 <= arg3) {
            if (*0x1::vector::borrow<u128>(arg1, v0) < *0x1::vector::borrow<u128>(arg1, arg2)) {
                0x1::vector::swap<0x3::staking_pool::StakedSui>(arg0, v0, v1);
                0x1::vector::swap<u128>(arg1, v0, v1);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        0x1::vector::swap<0x3::staking_pool::StakedSui>(arg0, arg2, v1 - 1);
        0x1::vector::swap<u128>(arg1, arg2, v1 - 1);
        v1 - 1
    }

    fun quick_sort(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut vector<u128>, arg2: u64, arg3: u64) {
        if (arg2 < arg3) {
            let v0 = partion(arg0, arg1, arg2, arg3);
            if (v0 > 1) {
                quick_sort(arg0, arg1, arg2, v0 - 1);
            };
            quick_sort(arg0, arg1, v0 + 1, arg3);
        };
    }

    public(friend) fun quick_sort_by_apy(arg0: &mut SuidoubleLiquidStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) {
        let v0 = epoch_staked_sui_growth_rates(arg0, arg1, arg2);
        let v1 = 0x1::vector::length<u128>(&v0);
        if (v1 > 1) {
            let v2 = &mut arg0.staked_pool;
            let v3 = &mut v0;
            quick_sort(v2, v3, 0, v1 - 1);
        };
    }

    public(friend) fun random_validator_address(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: vector<u8>) : address {
        let v0 = 0x3::sui_system::active_validator_addresses(arg0);
        0x1::vector::remove<address>(&mut v0, ((*0x1::vector::borrow<u8>(&arg1, 1) as u64) * 256 + (*0x1::vector::borrow<u8>(&arg1, 2) as u64)) % 0x1::vector::length<address>(&v0))
    }

    public(friend) fun random_validator_address_high_apy(arg0: &mut SuidoubleLiquidStaker, arg1: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: vector<u8>) : address {
        let v0 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::get_and_consume_metadata_next_validator(arg1);
        if (0x1::option::is_some<address>(&v0)) {
            return 0x1::option::destroy_some<address>(v0)
        };
        let v1 = 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool);
        if (v1 > 1) {
            let v2 = v1 - 1;
            while (v2 > 0) {
                let v3 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::validator_address_by_pool_id(arg1, 0x3::staking_pool::pool_id(0x1::vector::borrow<0x3::staking_pool::StakedSui>(&arg0.staked_pool, v2)));
                if (0x1::option::is_some<address>(&v3)) {
                    return 0x1::option::destroy_some<address>(v3)
                };
                v2 = v2 - 1;
            };
        };
        random_validator_address(arg2, arg3)
    }

    public(friend) fun rebalance(arg0: &mut SuidoubleLiquidStaker, arg1: u64, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        if (v0 < 8) {
            return v1
        };
        let v2 = 0;
        let v3 = v0 / 4;
        let v4 = v3;
        if (v3 > arg1) {
            v4 = arg1;
        };
        while (v2 < v4) {
            let v5 = 0x1::vector::remove<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, 0);
            arg0.staked_amount = arg0.staked_amount - 0x3::staking_pool::staked_sui_amount(&v5);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg3, v5, arg4));
            v2 = v2 + 1;
        };
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        if (v6 < 1000000000) {
            let v7 = RebalanceEvent{
                unstaked_count    : v2,
                restaked_amount   : 0,
                to_pending_amount : v6,
            };
            0x2::event::emit<RebalanceEvent>(v7);
            return v1
        };
        let v8 = &mut v1;
        stake_sui_v2(arg0, v8, arg2, arg3, arg4);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v10 = RebalanceEvent{
            unstaked_count    : v2,
            restaked_amount   : v6 - v9,
            to_pending_amount : v9,
        };
        0x2::event::emit<RebalanceEvent>(v10);
        v1
    }

    public(friend) fun stake_sui(arg0: &mut SuidoubleLiquidStaker, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg1);
        let v1 = v0 / 1000000000 * 1000000000;
        let v2 = v1;
        if (v1 > 0) {
            v2 = v0;
            let v3 = 0x2::object::new(arg3);
            0x2::object::delete(v3);
            let v4 = random_validator_address(arg2, 0x2::object::uid_to_bytes(&v3));
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::take<0x2::sui::SUI>(arg1, v0, arg3), v4, arg3));
            arg0.staked_amount = arg0.staked_amount + v0;
        };
        v2
    }

    public(friend) fun stake_sui_v2(arg0: &mut SuidoubleLiquidStaker, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg1);
        let v1 = v0 / 1000000000 * 1000000000;
        let v2 = v1;
        if (v1 > 0) {
            v2 = v0;
            if (v0 / 1000000000 > 5) {
                let v3 = 0x2::object::new(arg4);
                0x2::object::delete(v3);
                let v4 = random_validator_address_high_apy(arg0, arg2, arg3, 0x2::object::uid_to_bytes(&v3));
                let v5 = 0x2::coin::take<0x2::sui::SUI>(arg1, v0 * 4 / 5, arg4);
                arg0.staked_amount = arg0.staked_amount + 0x2::coin::value<0x2::sui::SUI>(&v5);
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, 0x3::sui_system::request_add_stake_non_entry(arg3, v5, v4, arg4));
                v2 = 0x2::balance::value<0x2::sui::SUI>(arg1);
            };
            let v6 = 0x2::object::new(arg4);
            0x2::object::delete(v6);
            let v7 = random_validator_address(arg3, 0x2::object::uid_to_bytes(&v6));
            let v8 = 0x3::sui_system::request_add_stake_non_entry(arg3, 0x2::coin::take<0x2::sui::SUI>(arg1, v2, arg4), v7, arg4);
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::store_address(arg2, 0x3::staking_pool::pool_id(&v8), v7);
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, v8);
            arg0.staked_amount = arg0.staked_amount + v2;
        };
        v2
    }

    public(friend) fun staked_amount(arg0: &SuidoubleLiquidStaker) : u64 {
        arg0.staked_amount
    }

    public(friend) fun staked_amount_available(arg0: &SuidoubleLiquidStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64) : u64 {
        expected_available_staked_balance(&arg0.staked_pool, arg1, arg2)
    }

    public(friend) fun staked_amount_with_rewards(arg0: &SuidoubleLiquidStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        expected_staked_balance(&arg0.staked_pool, arg1, 0x2::tx_context::epoch(arg2))
    }

    fun staking_pool_echange_rate_at_epoch(arg0: &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate>, arg1: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        let v0 = arg1 + 0;
        while (v0 >= 1) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, v0)) {
                return *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, v0)
            };
            v0 = v0 - 1;
        };
        let v1 = arg1 + 0;
        v0 = v1;
        while (v0 <= v1 + 7) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, v0)) {
                return *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, v0)
            };
            v0 = v0 + 1;
        };
        *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, 0)
    }

    public(friend) fun unstake_sui(arg0: &mut SuidoubleLiquidStaker, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
        let v2 = arg1 + 0;
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool) && v2 > 0) {
            let v4 = 0x1::vector::remove<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, 0);
            if (0x3::staking_pool::stake_activation_epoch(&v4) > 0x2::tx_context::epoch(arg3)) {
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v1, v4);
            } else {
                let v5 = 0x3::staking_pool::staked_sui_amount(&v4);
                let v6 = false;
                if (v5 > v2) {
                    if (v2 > 1000000000 && v5 - v2 > 1000000000) {
                        v6 = true;
                    };
                };
                let v7 = if (v6) {
                    let v7 = 0x3::staking_pool::split(&mut v4, v2, arg3);
                    0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v1, v4);
                    v7
                } else {
                    v4
                };
                let v8 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, v7, arg3);
                arg0.staked_amount = arg0.staked_amount - 0x3::staking_pool::staked_sui_amount(&v7);
                let v9 = 0x2::balance::value<0x2::sui::SUI>(&v8);
                if (v9 <= v2) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v8);
                    v2 = v2 - v9;
                } else {
                    v2 = 0;
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v8);
                };
            };
            v0 = v0 + 1;
        };
        0x1::vector::append<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, v1);
        v3
    }

    public(friend) fun unstake_sui_for_the_pool(arg0: &mut SuidoubleLiquidStaker, arg1: 0x2::object::ID, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.staked_pool)) {
            let v3 = 0x1::vector::remove<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, 0);
            if (0x3::staking_pool::pool_id(&v3) == arg1) {
                arg0.staked_amount = arg0.staked_amount - 0x3::staking_pool::staked_sui_amount(&v3);
                0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x3::sui_system::request_withdraw_stake_non_entry(arg2, v3, arg3));
            } else {
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v1, v3);
            };
            v0 = v0 + 1;
        };
        0x1::vector::append<0x3::staking_pool::StakedSui>(&mut arg0.staked_pool, v1);
        v2
    }

    // decompiled from Move bytecode v6
}

