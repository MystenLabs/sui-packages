module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker {
    struct SuiStaker has store {
        staked_sui_count: u64,
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        active_stake: 0x1::option::Option<0x3::staking_pool::FungibleStakedSui>,
        pending_stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        validator_address: address,
        pool_id: 0x2::object::ID,
        exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        last_refresh_epoch: u64,
    }

    public(friend) fun add_stake(arg0: &mut SuiStaker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.staked_sui_count = arg0.staked_sui_count + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < 1000000000) {
            return
        };
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)), arg3), arg0.validator_address, arg3);
        refresh_epoch(arg0, arg2, arg3);
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) {
            0x3::staking_pool::join_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake), v0);
        } else {
            0x1::option::fill<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake, v0);
        };
    }

    public(friend) fun collect_fees(arg0: &mut SuiStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_total_sui_amount(arg0, arg1, arg2);
        let v1 = arg0.staked_sui_count;
        assert!(v1 <= v0, 0);
        let v2 = remove_stake(arg0, v0 - v1, arg1, arg2);
        arg0.staked_sui_count = arg0.staked_sui_count + 0x2::coin::value<0x2::sui::SUI>(&v2);
        v2
    }

    public(friend) fun delete_sui_staker(arg0: SuiStaker) {
        assert!(0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake), 2);
        assert!(0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg0.pending_stake), 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) == 0, 4);
        assert!(arg0.staked_sui_count == 0, 5);
        let SuiStaker {
            staked_sui_count   : _,
            sui_pool           : v1,
            active_stake       : v2,
            pending_stake      : v3,
            validator_address  : _,
            pool_id            : _,
            exchange_rate      : _,
            last_refresh_epoch : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        0x1::option::destroy_none<0x3::staking_pool::FungibleStakedSui>(v2);
        0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v3);
    }

    fun get_latest_exchange_rate(arg0: &0x2::object::ID, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::tx_context::TxContext) : 0x1::option::Option<0x3::staking_pool::PoolTokenExchangeRate> {
        let v0 = 0x3::sui_system::pool_exchange_rates(arg2, arg0);
        let v1 = 0x2::tx_context::epoch(arg3);
        while (v1 > arg1) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1)) {
                return 0x1::option::some<0x3::staking_pool::PoolTokenExchangeRate>(*0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1))
            };
            v1 = v1 - 1;
        };
        0x1::option::none<0x3::staking_pool::PoolTokenExchangeRate>()
    }

    public(friend) fun get_staked_sui_count(arg0: &SuiStaker) : u64 {
        arg0.staked_sui_count
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        if (0x3::staking_pool::sui_amount(arg0) == 0 || 0x3::staking_pool::pool_token_amount(arg0) == 0) {
            return arg1
        };
        (((0x3::staking_pool::sui_amount(arg0) as u128) * (arg1 as u128) / (0x3::staking_pool::pool_token_amount(arg0) as u128)) as u64)
    }

    fun get_total_sui_amount(arg0: &mut SuiStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        refresh_epoch(arg0, arg1, arg2);
        let v0 = if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake)) {
            0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake))
        } else {
            0
        };
        let v1 = if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) {
            0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&arg0.pending_stake))
        } else {
            0
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) + get_sui_amount(&arg0.exchange_rate, v0) + v1
    }

    public(friend) fun init_staker(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : SuiStaker {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 1000000000, 1);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg2, arg1, arg0, arg3);
        let v1 = 0x3::staking_pool::pool_id(&v0);
        let v2 = get_latest_exchange_rate(&v1, 0, arg2, arg3);
        let v3 = SuiStaker{
            staked_sui_count   : 0,
            sui_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            active_stake       : 0x1::option::none<0x3::staking_pool::FungibleStakedSui>(),
            pending_stake      : 0x1::option::none<0x3::staking_pool::StakedSui>(),
            validator_address  : arg0,
            pool_id            : 0x3::staking_pool::pool_id(&v0),
            exchange_rate      : 0x1::option::extract<0x3::staking_pool::PoolTokenExchangeRate>(&mut v2),
            last_refresh_epoch : 0,
        };
        let v4 = &mut v3;
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg2, v0, arg3), arg3);
        add_stake(v4, v5, arg2, arg3);
        v3
    }

    fun refresh_epoch(arg0: &mut SuiStaker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) {
            if (0x3::staking_pool::stake_activation_epoch(0x1::option::borrow<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) <= 0x2::tx_context::epoch(arg2)) {
                if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake)) {
                    0x3::staking_pool::join_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut arg0.active_stake), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake), arg2));
                } else {
                    0x1::option::fill<0x3::staking_pool::FungibleStakedSui>(&mut arg0.active_stake, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake), arg2));
                };
                let v0 = get_latest_exchange_rate(&arg0.pool_id, arg0.last_refresh_epoch, arg1, arg2);
                if (0x1::option::is_some<0x3::staking_pool::PoolTokenExchangeRate>(&v0)) {
                    arg0.exchange_rate = 0x1::option::extract<0x3::staking_pool::PoolTokenExchangeRate>(&mut v0);
                };
                arg0.last_refresh_epoch = 0x2::tx_context::epoch(arg2);
            };
        };
    }

    public(friend) fun remove_stake(arg0: &mut SuiStaker, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0.staked_sui_count = arg0.staked_sui_count - arg1;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= arg1) {
            return 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, arg1), arg3)
        };
        let v0 = arg1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
        refresh_epoch(arg0, arg2, arg3);
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) {
            let v1 = 0x1::u64::max(v0, 1000000000);
            let v2 = if (0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&arg0.pending_stake)) < v1 + 1000000000) {
                0x1::option::extract<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake)
            } else {
                0x3::staking_pool::split(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut arg0.pending_stake), v1, arg3)
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg2, v2, arg3), arg3)));
        };
        if (arg1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) {
            if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake)) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::redeem_fungible_staked_sui(arg2, 0x3::staking_pool::split_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut arg0.active_stake), get_sui_amount(&arg0.exchange_rate, arg1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) + 1, arg3), arg3), arg3)));
            };
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= arg1, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

